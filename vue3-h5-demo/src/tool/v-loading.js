
export default {
    mounted(el, binding) {
        if (binding.value) {
            createLoading(el,binding);
        }
    },
    updated(el, binding) {
        if (binding.value) {
            createLoading(el,binding);
        } else {
            removeLoading(el,binding);
        }
    }
};

function createLoading(el, binding) {
    if (el._loadingElement) return;

    let mask = document.createElement("div");
    mask.className = "new-page";
    mask.style.zIndex = "4000";
    mask.addEventListener("click", (e) => e.stopPropagation());

    let loading_mask = document.createElement("div");
    loading_mask.className = "loading-mask";

    let spinner = document.createElement("div");
    spinner.className = "loading-spinner";

    //createCloseButton(loading_mask, () => {forceUpdate(el);});

    loading_mask.appendChild(spinner);
    mask.appendChild(loading_mask);
    el.appendChild(mask);
    el._loadingElement = mask;
}


function removeLoading(el) {
    if (el._loadingElement) {
        el.removeChild(el._loadingElement);
        el._loadingElement = null;
    }
}

function createCloseButton(parentElement, close) {
    const closeButton = document.createElement("div");
    closeButton.className = "flex-center";
    closeButton.style.position = "absolute";
    closeButton.style.top = "-.3rem";
    closeButton.style.right = "-.3rem";
    closeButton.style.width = "1rem";
    closeButton.style.height = "1rem";
    closeButton.style.zIndex = "3000";
    closeButton.style.cursor = "pointer";

    const icon = document.createElement("i");
    icon.className = "fa-sharp fa-regular fa-circle-xmark";
    icon.style.fontSize = ".45rem";

    closeButton.addEventListener("click", () => {
        if (typeof close === "function") {
            close();
        }
    });

    closeButton.appendChild(icon);
    parentElement.appendChild(closeButton);
}
