function validateform(obj)
{
    var username = obj.username.value;
    var phone = obj.phone.value;

    var city = document.getElementById("city");
    var city_index = city.selectedIndex;
    var city_value = city.options[city_index].value;

    var area = document.getElementById("area");
    var area_index = area.selectedIndex;
    var area_value = area.options[area_index].value;

    var address = obj.address.value;

    var userreg = /[^\u4e00-\u9fa5]/;
    if(username.length == 0){
        alert('请填写收货人姓名');
        obj.username.focus();
        return false;
    }else if(userreg.test(username)){
        alert('收货人请填中文名称');
        obj.username.focus();
        return false;
    }

    var phonereg = /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/; 
    if(phone.length < 1){
        alert('请填写手机号码');
        obj.phone.focus();
        return false;
    }else if(phone.length !== 11 || !phonereg.test(phone)){
        alert('请填写正确的手机号码');
        obj.phone.focus();
        return false;
    }


    if(city_value == 0){
        alert('请选择省份');
        obj.city.focus();
        return false;
    }

    if(area_value == 0){
        alert('请选择县/市');
        obj.area.focus();
        return false;
    }

    if(address.length == 0 ){
        alert('请填写详细地址');
        obj.address.focus();
        return false;
    }
    return true;
}