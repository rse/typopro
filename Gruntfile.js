
/* global module: true */
module.exports = function (grunt) {
    grunt.loadNpmTasks("grunt-contrib-clean")
    grunt.loadNpmTasks("grunt-contrib-copy")
    grunt.loadNpmTasks("grunt-bower-install-simple")
    grunt.initConfig({
        pkg: grunt.file.readJSON("package.json"),
        copy: {
            "normalize": {
                src: [ "node_modules/normalize.css/normalize.css" ],
                dest: "lib/normalize/normalize.css"
            },
            "jquery": {
                src: [ "node_modules/jquery/dist/jquery.js" ],
                dest: "lib/jquery/jquery.js"
            },
            "typopro": {
                files: [
                    { expand: true, flatten: false, cwd: "node_modules/typopro-web/web",
                      src: "TypoPRO-OpenSans/**", dest: "lib/typopro/" },
                    { expand: true, flatten: false, cwd: "node_modules/typopro-web/web",
                      src: "TypoPRO-DejaVu/**", dest: "lib/typopro/" },
                    { expand: true, flatten: false, cwd: "node_modules/typopro-web/web",
                      src: "**", dest: "specimen/" },
                ]
            },
            "typopro-index": {
                files: [
                    { dest: "specimen/index.html",    src: [ "node_modules/typopro-web/index.html" ] },
                    { dest: "specimen/specimen.html", src: [ "node_modules/typopro-web/specimen.html" ] }
                ]
            },
            "typopro-index-manifest": {
                src: [ "node_modules/typopro-web/manifest.js" ],
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
            distclean: [ "node_modules" ]
        }
    })
    grunt.registerTask("default", [ "copy" ])
}

