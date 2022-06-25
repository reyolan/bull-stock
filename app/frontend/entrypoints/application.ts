import * as ActiveStorage from "@rails/activestorage";
import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import "../../assets/stylesheets/application.css";
import "./scripts/mobile_navigation";

ActiveStorage.start();
Rails.start();
Turbolinks.start();
