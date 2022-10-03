import {uglify} from "rollup-plugin-uglify";

export default {
  input: './suiport.js',
  output: {
    file: 'suiport.min.js',
    format: 'iife'
  },
  plugins: [
    uglify()
  ]
};