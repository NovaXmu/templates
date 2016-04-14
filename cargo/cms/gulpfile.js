var gulp = require("gulp");
var reactify = require("reactify");
var watchify = require("watchify");
var browserify = require("browserify");
var concat = require("gulp-concat");
var source = require("vinyl-source-stream");
var watch = require("gulp-watch");
var sass = require("gulp-sass");
var gutil = require("gulp-util");
var plumber = require("gulp-plumber");
var server = require("gulp-server-livereload");
var notify = require("gulp-notify");
var autoprefixer = require("gulp-autoprefixer");
var uglify = require("gulp-uglify");
var rename = require("gulp-rename");
var buffer = require("vinyl-buffer");

var b = browserify({
    entries: ["./src/js/main.jsx"],
    transform: [reactify],
    extensions: [".jsx"],
    debug: true,
    cache: {},
    packageCache: {},
    fullPaths: true,
    plugin: [watchify]
});

var note = function(error) {
    var message = 'In: ';
    var title = 'Error: ';

    if(error.description) {
        title += error.description;
    } else if (error.message) {
        title += error.message;
    }

    if(error.filename) {
        var file = error.filename.split('/');
        message += file[file.length-1];
    }

    if(error.lineNumber) {
        message += '\nOn Line: ' + error.lineNumber;
    }

    //notifier.notify({title: title, message: message});
    console.log(title + "\n" + message);
};

function build() {
    return b.bundle()
        .on('error', note)
        .pipe(source('cms.js'))
        .pipe(plumber({errorHandler: notify.onError("Error: <%= error.message %>")}))
        .pipe(gulp.dest('./dist/js'))
        .pipe(rename({ suffix: ".min" }))
        .pipe(buffer())
        .pipe(uglify())
        .pipe(gulp.dest('./dist/js'))
        .pipe(notify("scripts built"))

}

b.on('update', build);

gulp.task('build', function() {
    build()
});

gulp.task('serve', function(done) {
    gulp.src('dist')
        .pipe(server({
            livereload: {
                enable: true,
                filter: function(filePath, cb) {
                    if(/dist/.test(filePath)) {
                        cb(true);
                    }
                }
            },
            open: true
        }));
});

gulp.task('sass', function () {
    gulp.src('./src/css/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(concat('style.css'))
        .pipe(autoprefixer({
            browsers: ['> 1%']
        }))
        .pipe(gulp.dest('./dist/css/'))
        .pipe(notify("sass compiled"));
});

gulp.task('watch', function () {
    gulp.watch('./src/css/*.scss', ['sass']);
});

gulp.task('default', ['build', 'sass', 'watch', 'serve']);

