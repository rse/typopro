
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
                    { expand: true, flatten: false, cwd: "bower_components/typopro/web",
                      src: "TypoPRO-OpenSans/**", dest: "lib/typopro/" },
                    { expand: true, flatten: false, cwd: "bower_components/typopro/web",
                      src: "TypoPRO-DejaVu/**", dest: "lib/typopro/" },
                    { expand: true, flatten: false, cwd: "bower_components/typopro/web",
                      src: "**", dest: "specimen/" },
                ]
            },
            "typopro-index": {
                files: [
                    { dest: "specimen/index.html",    src: [ "bower_components/typopro/index.html" ] },
                    { dest: "specimen/specimen.html", src: [ "bower_components/typopro/specimen.html" ] },
                    { dest: "specimen/manifest.js",   src: [ "bower_components/typopro/etc/manifest.js" ] }
                ],
                options: {
                    process: function (content, srcpath) {
                        return content.replace(/web\//g, "").replace(/etc\/manifest\.js/g, "manifest.js");
                    }
                }
            },
        },
        clean: {
            clean:     [ "lib" ],
            distclean: [ "node_modules", "bower_components" ]
        }
    });

    grunt.registerTask("default", [ "bower-install-simple", "copy" ]);
};

