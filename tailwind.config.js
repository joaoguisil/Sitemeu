// tailwind.config.js
module.exports = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        'black-primary': '#0B0B0B',
        'gray-primary': '#1E1E1E',
        'blue-dark': '#0A3D62',
        'blue-light': '#2E86DE',
      },
      backgroundImage: {
        'gradient-dark': 'linear-gradient(to right, #0B0B0B, #0A3D62)',
      },
    },
  },
  plugins: [],
}
