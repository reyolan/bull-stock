import * as ActiveStorage from "@rails/activestorage";
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import "../../assets/stylesheets/application.css";

ActiveStorage.start();
Rails.start();
Turbolinks.start();

console.log("Vite ⚡️ Rails");

console.log(
  "Visit the guide for more information: ",
  "https://vite-ruby.netlify.app/guide/rails"
);
