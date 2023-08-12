import Web3 from "web3";
import { abi, networks } from "../../../build/contracts/ProductVerification.json"
const web3 = new Web3(window.ethereum);
$(document).ready(function() {
    

    let medicineID = $('#medicineID').value;
    let button = document.getElementById('button')
    medicineID = parseInt(medicineID)
    $('#button').click(function (e) {  
        const contract = new web3.eth.Contract(abi, networks[1680983828029].address);
        const detail = contract.methods.returnDetails(medicineID).call();
        console.log(detail);
    });
    (function($) {
        $.fn.timeline = function() {
            var selectors = {
                id: $(this),
                item: $(this).find(".timeline-item"),
                activeClass: "timeline-item--active",
                img: ".timeline__img"
            };
            selectors.item.eq(0).addClass(selectors.activeClass);
            selectors.id.css(
                "background-image",
                "url(" +
                selectors.item
                .first()
                .find(selectors.img)
                .attr("src") +
                ")"
            );
            var itemLength = selectors.item.length;
            $(window).scroll(function() {
                var max, min;
                var pos = $(this).scrollTop();
                selectors.item.each(function(i) {
                    min = $(this).offset().top;
                    max = $(this).height() + $(this).offset().top;
                    var that = $(this);
                    if (i == itemLength - 2 && pos > min + $(this).height() / 2) {
                        selectors.item.removeClass(selectors.activeClass);
                        selectors.id.css(
                            "background-image",
                            "url(" +
                            selectors.item
                            .last()
                            .find(selectors.img)
                            .attr("src") +
                            ")"
                        );
                        selectors.item.last().addClass(selectors.activeClass);
                    } else if (pos <= max - 40 && pos >= min) {
                        selectors.id.css(
                            "background-image",
                            "url(" +
                            $(this)
                            .find(selectors.img)
                            .attr("src") +
                            ")"
                        );
                        selectors.item.removeClass(selectors.activeClass);
                        $(this).addClass(selectors.activeClass);
                    }
                });
            });
        };
    })(jQuery);

    $("#timeline-1").timeline();


});