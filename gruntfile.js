'use strict';
//
//
// # NOTES
// ================================================================================================
// ================================================================================================



//
// # GRUNT / NODE	FILE	MATCHING	(GLOBBING)
// ----------------------------------------------
//
// Restrict matching to the content of one directory level down (i.e. single directory nesting):
//		'SomeRootDirectory/{,*/}*.js'
// Full Recursion, matching the content files in all subdirectoy levels:
//		'SomeRootDirectory/**/*.js'
// Full Recursion, matching All content:
//		'SomeRootDirectory/**'
// Skip a directory during recursion:
//		'!**/SkipThisDirectoryName/**'


//
//
// # Initialization of Any External Processor Objs
// ================================================================================================
// ================================================================================================


//
//
// # Definition of Grunt Task Handling
// ================================================================================================
// ================================================================================================

module.exports = function(grunt)
{
	//
	// # Load Sub-modules (i.e. Grunt Tasks)
	// (Simplify with "matchdep" or "load-grunt-tasks" or get fancy with "load-grunt-config")
	// ------------------------------

	// Load All Grunt Task Types Listed in the Node package.json in devDependencies
	require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

	//
	// # Configure App Structure References
	// --------------------------------------------------------------------------------------------

	var BuildConfigs = {
		temp: {
			root: "__Temp",
			desktop: "__Temp/Desktop Font Files",
			web: "__Temp/Web Font Files"
		}
	};




	//
	// # Configure Grunt Tasks
	// --------------------------------------------------------------------------------------------

	grunt.initConfig({
		// Read in the Node package.json File So its Content is Available to Processes
		NodePkg: grunt.file.readJSON('package.json'),
		BuildConfigs: BuildConfigs,


		clean: {
			full: {
				options: { 'no-write': false },
				src: [	'<%= BuildConfigs.temp.root %>'
				]
			},
			full_test: {
				options: { 'no-write': true },// Don't Actually Delete Anything
				src: [	'<%= BuildConfigs.temp.root %>'
				]
			},
			strip_to_source: {
				options: { 'no-write': false },
				src: [	'<%= BuildConfigs.temp.root %>',
						'node_modules'
				]
			}
		},
		// End Clean Task Defs


		typopro: {
			options: {
				directory: '<%= BuildConfigs.temp.web %>',
				mergecss: true,
				fonts: [ "SourceCodePro", "OpenSans" ]
			}
		},
		// End TypoPro Task Defs

	});


	//
	// # Register (Executable) Grunt Task Aliases
	// --------------------------------------------------------------------------------------------

	// Define the DEFAULT task - executed when running grunt with no arguments
	grunt.registerTask('default', ['BasicWorkBuild']);


	grunt.registerTask('BasicWorkBuild', 'Starts the Development Build Cycle, Express Web Server, and Watches  < DEFAULT >',
		function() {
			grunt.task.run([
				'clean:full',
				'typopro'
			]);
		}
	);


	grunt.registerTask('Nuke', 'Clears All Build Content and Strips Down to Only Source (NPM Install will be Required to Work Again).',
		function() {
			grunt.task.run([
				'clean:strip_to_source'
			]);
		}
	);
};
