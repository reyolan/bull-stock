document.addEventListener("turbolinks:load", () => {
  const hamburgerIcon = document.querySelector("#hamburger");
  const menuList = document.querySelector("#list")!;

  if (!hamburgerIcon) return;

  hamburgerIcon.addEventListener("click", () => {
    if (menuList.classList.contains("hidden")) {
      menuList.classList.remove("hidden");
      return;
    }
    menuList.classList.add("hidden");
  });
});
