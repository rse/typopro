
/* global module: true */
module.exports = function (grunt) {
    grunt.loadNpmTasks("grunt-contrib-clean");
    grunt.loadNpmTasks("grunt-contrib-copy");
    grunt.loadNpmTasks("grunt-bower-install-simple");

    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),
        "bower-install-simple": {
            main: {
                options: {
                    color:       true,
                    production:  true,
                    directory:   "bower_components"
                }
            }
        },
        copy: {
            "normalize": {
                src: [ "bower_components/normalize.css/normalize.css" ],
                dest: "lib/normalize/normalize.css"
            },
            "jquery": {
                src: [ "bower_components/jquery/dist/jquery.js" ],
                dest: "lib/jquery/jquery.js"
            },
            "typopro": {
                files: [
                    { expand: true, flatten: false, cwd: "bower_components/typopro-web/web",
                      src: "TypoPRO-OpenSans/**", dest: "lib/typopro/" },
                    { expand: true, flatten: false, cwd: "bower_components/typopro-web/web",
                      src: "TypoPRO-DejaVu/**", dest: "lib/typopro/" },
                    { expand: true, flatten: false, cwd: "bower_components/typopro-web/web",
                      src: "**", dest: "specimen/" },
                ]
            },
            "typopro-index": {
                files: [
                    { dest: "specimen/index.html",    src: [ "bower_components/typopro-web/index.html" ] },
                    { dest: "specimen/specimen.html", src: [ "bower_components/typopro-web/specimen.html" ] }
                ]
            },
            "typopro-index-manifest": {
                src: [ "bower_components/typopro-web/manifest.js" ],
                dest: "specimen/manifest.js",
                options: {
                    process: function (content, srcpath) {
                        return content.replace(/web\//g, "");
                    }
                }
            }
        },
        clean: {
            clean:     [ "lib" ],
            distclean: [ "node_modules", "bower_components" ]
        }
    });

    grunt.registerTask("default", [ "bower-install-simple", "copy" ]);
};

