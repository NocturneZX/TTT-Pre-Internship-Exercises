function callNativeApp () {
    try {
        webkit.messageHandlers.callbackHandler.postMessage("Hello from JavaScript");
    } catch(err) {
        console.log('The native context does not exist yet');
    }
}

setTimeout(function () {
    callNativeApp();
}, 5000);

function redHeader() {
    document.querySelector('h1').style.color = "red";
}

var button = document.getElementById("clickMeButton");
button.addEventListener("click", function() {
                        var messageToPost = {'ButtonId':'clickMeButton'};
                        window.webkit.messageHandlers.buttonClicked.postMessage(messageToPost);
                        },false);