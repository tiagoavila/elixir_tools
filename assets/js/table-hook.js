export const TableHook = {
    mounted() {
        function attachHoverEvents() {
            const tableCells = document.querySelectorAll("#data-grid td");

            tableCells.forEach(cell => {
                cell.addEventListener("mouseover", (event) => {
                    const row = event.target.getAttribute("data-row");
                    const col = event.target.getAttribute("data-col");

                    // Create or update the display element
                    let infoBox = document.getElementById("info-box");
                    if (!infoBox) {
                        infoBox = document.createElement("div");
                        infoBox.id = "info-box";
                        infoBox.style.position = "fixed";
                        infoBox.style.backgroundColor = "#fff";
                        infoBox.style.border = "1px solid #ccc";
                        infoBox.style.padding = "5px";
                        infoBox.style.borderRadius = "5px";
                        infoBox.style.boxShadow = "0px 2px 4px rgba(0, 0, 0, 0.1)";
                        document.body.appendChild(infoBox);
                    }

                    // Update the info box content
                    infoBox.textContent = `Row: ${row}, Col: ${col}`;

                    // Position the info box near the cursor
                    const mouseX = event.pageX;
                    const mouseY = event.pageY;
                    infoBox.style.left = `${mouseX + 10}px`;
                    infoBox.style.top = `${mouseY + 10}px`;
                });

                cell.addEventListener("mouseout", () => {
                    const infoBox = document.getElementById("info-box");
                    if (infoBox) {
                        infoBox.remove();
                    }
                });
            });
        };
    
        attachHoverEvents();
    },
    updated() {
    }
}