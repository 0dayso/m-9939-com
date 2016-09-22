<?php

/**
 * 创建资讯结构化数据
 */
class App_Model_CreateArticleStruct {

    public function createXml() {
        $art_obj = new App_Model_Article();
        $top_art_list = $art_obj->GetArtMaxId('status in (19,20)', 'articleid desc', 0, 1);
        $max_article_id = $top_art_list['articleid'];
        $structdata_path = 'structdatas';
        $maps_path = $structdata_path . DIRECTORY_SEPARATOR . 'articlesitemaps';
        $save_sitemap_dir = __PUBLIC__ . DIRECTORY_SEPARATOR . $maps_path;
        if (!file_exists($save_sitemap_dir)) {
            mkdir($save_sitemap_dir, 0777, true);
        }
        $data_max_articleid = 0;
        $max_file_index = 0;
        $data_max_articleid_file = $save_sitemap_dir . DIRECTORY_SEPARATOR . 'max_articleid.php';
        if (is_file($data_max_articleid_file)) {
            $content = file_get_contents($data_max_articleid_file);
            $data = unserialize($content);
            $data_max_articleid = $data['max_articleid']; //同缓存文件中读取上次的最大文章ID
            $max_file_index = $data['max_file_index'];
        }
        if ($data_max_articleid >= $max_article_id) {
            echo '无新数据,不需要更新sitemap';
            exit;
        }
        $max_diff = 2000; //每个文件放的记录数
        $start_article_id = $data_max_articleid;
        $file_index = $max_file_index + 1;
        $return_info = array();
        $max_article_id = $start_article_id + $max_diff;
        while ($start_article_id < $max_article_id) {
            if ($start_article_id >= $max_article_id) {
                break;
            }
            $end_article_id = $start_article_id + $max_diff;
            $art_list = array();
            $this->getCreateData($start_article_id, $max_article_id, $max_diff, $art_list);
            $data = array();
            $total_record = count($art_list);
            if ($total_record > 0) {
                $end_article_id = $art_list[$total_record - 1]['articleid'];
                if ($end_article_id < ($start_article_id + $max_diff)) {
                    $end_article_id = $start_article_id + $max_diff;
                }
            } else {
//                $arr = array('max_articleid' => $max_article_id,'max_file_index'=>$file_index-1, 'addtime' => time());
//                $content = serialize($arr);
//                file_put_contents($data_max_articleid_file, $content);
//                $this->createXml();
            }
            $datas = array();
            foreach ($art_list as $k => $v) {
                $node = array();
                $node_1 = array();
                $part_url = explode('//', $v['url']);
                $part_url2 = explode('.', $part_url[1]);
                $node['url'] = sprintf("http://m.9939.com/" . $part_url2[0] . "/article/%d.shtml", $v['articleid']);
                $title = $this->screening($v['title']);
                $node['title'] = "\xEF\xBB\xBF" . $title;
                $description = $this->screening($v['description']);
                $node['summary'] = $description;  //文章摘要
                $node['contentType'] = 1;
                $node['publishDate'] = date('Y-m-d H:i:s', $v['inputtime']);
                $category = $art_obj->getcategory($v['catid']);
                $node['channel1'] = !empty($category[0]['catname']) ? $category[0]['catname'] : '';
                $node['channel2'] = !empty($category[1]['catname']) ? $category[1]['catname'] : '';
                $node['channel3'] = !empty($category[2]['catname']) ? $category[2]['catname'] : '';
                $keywords = $this->screening($v['keywords']);
                $node['tags'] = $keywords;
                $node_1['item'] = $node;
                $datas[] = $node_1;
            }
            $data_list['webName'] = '久久健康网';
            $data_list['hostName'] = 'm.9939.com';
            $data_list['datalist'] = $datas;
            $data[] = $data_list;
            if (count($data_list['datalist']) > 0) {
                $filename = sprintf('articlesitemap%d.xml', $file_index);
                $root_name = 'document';
                $return_save_info = QLib_Xml_Client::createxmlfile($data, $filename, $save_sitemap_dir, $root_name, array(), true);
                if ($return_save_info) {
                    $return_info[] = sprintf('<a href="http://m.9939.com/%s/%s" target="_blank">%s</a>', $maps_path, $filename, $filename);
                }
                $file_index++;
            }
            $start_article_id = $end_article_id;
        }
        $max_article_id = $start_article_id;
        if (count($return_info) >= 0) {
            $sitemap_files = scandir($save_sitemap_dir);
            $sitemap_index_data = array();
            foreach ($sitemap_files as $k => $v) {
                if (!in_array($v, array(".", ".."))) {
                    $r_real_path = realpath($save_sitemap_dir . '/' . $v);
                    if (is_file($r_real_path) && stripos($v, '.xml')) {
                        $xml_url = sprintf('http://m.9939.com/%s/%s', $maps_path, $v);
                        $node = array();
                        $node['loc'] = $xml_url;
                        $node['lastmod'] = date('Y-m-d H:i:s', fileatime($r_real_path));
                        $node_parent = array('sitemap' => $node);
                        $sitemap_index_data[] = $node_parent;
                    }
                }
            }
            $save_sitemapindex_path = dirname($save_sitemap_dir);
            $sitemap_index_filename = sprintf('article%s.xml', 'indexfile');
            $root_name = 'sitemapindex';
            $root_attr = array('xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9/');
            $return_save_info = QLib_Xml_Client::createxmlfile($sitemap_index_data, $sitemap_index_filename, $save_sitemapindex_path, $root_name, $root_attr);

            if ($return_save_info) {
                $return_info[] = sprintf('<a href="http://m.9939.com/%s/%s" target="_blank">%s</a>', $structdata_path, $sitemap_index_filename, $sitemap_index_filename);
                $msg = implode("\n<br />", $return_info);
                echo $msg;
                echo '<br />';
                echo '生成成功';
                $arr = array('max_articleid' => $max_article_id, 'max_file_index' => $file_index - 1, 'addtime' => time());
                $content = serialize($arr);
                file_put_contents($data_max_articleid_file, $content);
            }
        }
    }

    private function getCreateData($start_article_id = 0, $max_article_id = 0, $max_diff = 10000, &$art_list = array()) {
        $total_record = count($art_list);
        if ($total_record <= $max_diff && $start_article_id <= $max_article_id) {
            $art_obj = new App_Model_Article();
            $end_article_id = $start_article_id + $max_diff;
            $where = "a.articleid > '{$start_article_id}' and a.articleid<='{$end_article_id}' and status in (19,20) ";
            $offset = 0;
            $answers = '';
            $count = $max_diff - $total_record;
            if ($count > 0) {
                $tmp_art_list = $art_obj->getArtList($where, 'a.articleid asc', $count, $offset);
                $liat_detail = array();
                foreach ($tmp_art_list as $k => $datas) {
                    if ($datas['channel_id'] != '9366') {
                        $liat_detail[] = $datas;
                    }
                }
                $tmp_art_list = $liat_detail;
                if ($tmp_art_list) {
                    $art_list = array_merge($art_list, $tmp_art_list);
                    $total_record = count($art_list);
                    $start_article_id = $art_list[$total_record - 1]['articleid'];
                } else {
                    $start_article_id = $end_article_id;
                    $total_record = count($art_list);
                }
                $this->getCreateData($start_article_id, $max_article_id, $max_diff, $art_list);
            }
        }
    }

    private function screening($content) {
        $content = strip_tags($content); //过滤所有的html页面
        $content = str_replace("&nbsp;", "", $content); //过滤空格
        $content = str_replace(PHP_EOL, '', $content); //过滤换行
        $search = array(" ", "　", "", "", "", "", "", "", "", "\n", "\r", "\t", "", ""); //过滤空格、特殊字符
        $replace = array("", "", "", "", "", "", "", "", "", "", "", "", "", "");
        return str_replace($search, $replace, $content);
    }

}
