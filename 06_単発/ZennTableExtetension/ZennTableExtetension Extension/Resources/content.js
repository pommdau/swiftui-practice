browser.runtime.sendMessage({ greeting: "hello" }).then((response) => {
    console.log("Received response: ", response);
//    const element = document.getElementById('firstHeading');
//    element.remove();
    const elements = document.getElementsByClassName("ol-depth-1");
    
    var item = document.createElement("li");
    item.textContent = "Hello, 🐱"

    elements[0].appendChild(item);

});

browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
});
