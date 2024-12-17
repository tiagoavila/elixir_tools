export const TextAreaHook = {
    mounted() {
        document.getElementById("input-area").focus();
        this.el.addEventListener("input", e => {
            this.pushEvent("parse_text", { text: e.target.value })
        })
    }
}