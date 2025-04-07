const path = require("path");

module.exports = {
  mode: "production",
  entry: "./src/index.js",
  output: {
    filename: "[name].[contenthash].js", // Good for caching
    chunkFilename: "[name].[contenthash].js",
    path: path.resolve(__dirname, "dist"), // 'build' instead of 'dist'
    library: {
      name: "@egovernments/digit-ui-svg-components",
      type: "umd",
    },
    globalObject: "this", // Makes UMD work in both browser and Node
    // publicPath: Removed, not needed for libraries
  },
  resolve: {
    extensions: [".js"],
  },
  externals: {
    react: {
      commonjs: "react",
      commonjs2: "react",
      amd: "react",
      root: "React",
    },
    "react-dom": {
      commonjs: "react-dom",
      commonjs2: "react-dom",
      amd: "react-dom",
      root: "ReactDOM",
    },
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ["@babel/preset-env", "@babel/preset-react"],
          },
        },
      },
    ],
  },
  optimization: {
    runtimeChunk: "single",
    moduleIds: "hashed",
    splitChunks: {
      chunks: "all",
      minSize: 30000,
      maxSize: 250000,
      minChunks: 1,
      maxAsyncRequests: 30,
      maxInitialRequests: 30,
      cacheGroups: {
        vendor: {
          test: /[\\/]node_modules[\\/]/,
          name: "vendors",
          chunks: "all",
        },
        common: {
          test: /[\\/]src[\\/]/,
          name: "common",
          minChunks: 2,
        },
      },
    },
  },
};
