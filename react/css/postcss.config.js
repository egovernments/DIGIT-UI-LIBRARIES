module.exports = {
  parser: "postcss-scss",
  plugins: [
    require("postcss-import"),
    require("postcss-nested"),
    require("tailwindcss"),
    require("postcss-preset-env")({
      stage: 2,
      autoprefixer: { cascade: false },
      features: { "custom-properties": true },
    }),
    require("autoprefixer"),
    require("cssnano")({
      preset: "default",
    }),
  ],
};
