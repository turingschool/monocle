$(document).ready( function(){

});

function checkCompanyFields() {

    var x, y, z, a, b, c, d, e, f, text;

    x = document.getElementById("location_street_address").value;
    y = document.getElementById("location_phone").value;
    z = document.getElementById("location_primary_contact").value;
    a = document.getElementById("location_city").value;
    b = document.getElementById("location_zip_code").value;
    c = document.getElementById("company_website").value;
    d = document.getElementById("company_headquarters").value;
    e = document.getElementById("company_products_services").value;
    f = document.getElementById("company_name").value;

    if (x == "") {
        text = "This field is required!";
        document.getElementById("street_address_req").innerHTML = text;
        return false
    }
    if (y == "") {
        text = "This field is required!";
        document.getElementById("phone_req").innerHTML = text;
        return false
    }
    if (z == "") {
        text = "This field is required!";
        document.getElementById("primary_contact_req").innerHTML = text;
        return false
    }
    if (a == "") {
        text = "This field is required!";
        document.getElementById("city_req").innerHTML = text;
        return false
    }
    if (b == "") {
        text = "This field is required!";
        document.getElementById("zip_req").innerHTML = text;
        return false
    }
    if (c == "") {
        text = "This field is required!";
        document.getElementById("website_req").innerHTML = text;
        return false
    }
    if (d == "") {
        text = "This field is required!";
        document.getElementById("headquarters_req").innerHTML = text;
        return false
    }
    if (e == "") {
        text = "This field is required!";
        document.getElementById("services_req").innerHTML = text;
        return false
    }
    if (f == "") {
        text = "This field is required!";
        document.getElementById("name_req").innerHTML = text;
        return false
    }
};
