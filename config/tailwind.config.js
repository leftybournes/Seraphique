const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
	content: [
		'./public/*.html',
		'./app/helpers/**/*.rb',
		'./app/javascript/**/*.js',
		'./app/views/**/*.{erb,haml,html,slim}'
	],
	safelist: [
		...[...Array(101).keys()].flatMap(index => `w-[${index}%]`)
	],
	theme: {
		extend: {
			fontFamily: {
				sans: ['Inter var', ...defaultTheme.fontFamily.sans],
				poppins: ['Poppins', ...defaultTheme.fontFamily.sans]
			},
			colors: {
				seraphique: '#3A5033'
			}
		},
	},
	plugins: [
		require('@tailwindcss/forms'),
		require('@tailwindcss/typography'),
		require('@tailwindcss/container-queries'),
	]
};
