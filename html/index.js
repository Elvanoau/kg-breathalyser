const resource = GetParentResourceName();
let brethoOn = false;

$(function() {
    window.addEventListener('message', function(event) {
        if(event.data.type == "open") {
            if (brethoOn == false) {
                $("#brethoimage").attr("src","images/bretho_off.png");
                $("#bretho").css("display", "block");
                $(".screeninfo").css("display", "none");
            } else {
                $("#brethoimage").attr("src","images/bretho.png");
                $("#bretho").css("display", "block");
                $(".screeninfo").css("display", "block");
                $("#curvol").html(event.data.amount);
            }
        } else if(event.data.type == "close") {
            $("#brethoimage").attr("src","images/bretho.png");
            $("#bretho").css("display", "none");
            $(".screeninfo").css("display", "none");
        } else if(event.data.type == "data") {
            $("#curvol").html(event.data.amount);
        } else if (event.data.type == "over") {
            $("#brethoimage").attr("src","images/bretho_over.png");
            $("#curvol").html(event.data.amount);
        }
    });

    document.onkeyup = function (data) {
        if (data.key == "Escape") { // Escape key
            $.post(`https://${resource}/escape`, JSON.stringify({}));
        }
        else if (data.key == "E") { // E key
            if (brethoOn == true) {
                $.post(`https://${resource}/breth`, JSON.stringify({}));
            }
        }
    };
});

function OnOff() {
    if (brethoOn) {
        brethoOn = false;
        $("#brethoimage").attr("src","images/bretho_off.png");
        $("#bretho").css("display", "block");
        $(".screeninfo").css("display", "none");
    } else {
        brethoOn = true;
        $("#brethoimage").attr("src","images/bretho.png");
        $("#bretho").css("display", "block");
        $(".screeninfo").css("display", "block");
        $("#curvol").html("0.000");
    };
};
