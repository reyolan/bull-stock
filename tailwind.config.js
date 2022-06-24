module.exports = {
  content: [
    "./app/helpers/**/*.rb",
    "./app/frontend/entrypoints/*.ts",
    "./app/views/**/*",
  ],
  theme: {
    extend: {},
  },
  plugins: [require("@tailwindcss/forms")],
};
