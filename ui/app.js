var Selected_Loc = null;

window.addEventListener("message", function(event) {
    if (event.data.Action == 'ShowUi') {
        if (event.data.Display) {
            document.body.style.display = 'block';
            ShowUi(event.data.Data);
        } else {
            document.body.style.display = 'none';
        }
    }
});

function ShowUi(locations) {
    console.log(JSON.stringify(locations));
    const locationsContainer = document.querySelector(".locations");
    
    locations.forEach(location => {
        const div = document.createElement("div");
        div.className = "location";
        
        div.innerHTML = `
            <svg xmlns="http://www.w3.org/2000/svg" width="36" height="36" viewBox="0 0 36 36" fill="none">
                <path d="M26.4855 7.956C21.7995 3.3465 14.202 3.3465 9.516 7.956C8.40342 9.04295 7.51936 10.3413 6.91577 11.7749C6.31218 13.2084 6.00125 14.7481 6.00125 16.3035C6.00125 17.8589 6.31218 19.3986 6.91577 20.8321C7.51936 22.2656 8.40342 23.564 9.516 24.651L18 32.9985L26.4855 24.651C27.5981 23.564 28.4821 22.2656 29.0857 20.8321C29.6893 19.3986 30.0002 17.8589 30.0002 16.3035C30.0002 14.7481 29.6893 13.2084 29.0857 11.7749C28.4821 10.3413 27.5981 9.04295 26.4855 7.956ZM18 20.2485C16.998 20.2485 16.0575 19.8585 15.348 19.1505C14.6456 18.4466 14.2512 17.4929 14.2512 16.4985C14.2512 15.5041 14.6456 14.5504 15.348 13.8465C16.056 13.1385 16.998 12.7485 18 12.7485C19.002 12.7485 19.944 13.1385 20.652 13.8465C21.3544 14.5504 21.7488 15.5041 21.7488 16.4985C21.7488 17.4929 21.3544 18.4466 20.652 19.1505C19.944 19.8585 19.002 20.2485 18 20.2485Z" />
            </svg>
        `;
        
        div.style.top = location.Css.top;
        div.style.left = location.Css.left;
        
        div.addEventListener("click", () => {
            document.querySelector(".current-location img").src = location.Image;
            document.querySelector(".current-location h3").textContent = location.Loc_Name;
            Selected_Loc = location.Loc_Name;
        });
        
        locationsContainer.appendChild(div);
    });
    
    document.querySelector(".current-location img").src = locations[0].Image;
    document.querySelector(".current-location h3").textContent = locations[0].Loc_Name;
    Selected_Loc = locations[0].Loc_Name;
}

function Spawn() {
    fetch('https://spawn-selector/spawn', {
        method: 'POST',
        body: JSON.stringify({ location: Selected_Loc }),
    });

    document.body.style.display = "none";
}

function Spawn2() {
    fetch('https://spawn-selector/last-loc', {
        method: 'POST',
        body: JSON.stringify({}),
    });

    document.body.style.display = "none";
}