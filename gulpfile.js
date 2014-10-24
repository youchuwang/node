var gulp = require('gulp'),
    uglify = require('gulp-uglify'),
    minifyCss = require('gulp-minify-css'),
    coffee = require('gulp-coffee'),
    less = require('gulp-less'),
    rename = require('gulp-rename'),
    gutil = require('gulp-util'),
    concat = require('gulp-concat'),
    clean = require('gulp-clean'),
    connect = require('gulp-connect');
    // require('daemon')();

gulp.task('connect', ['compile'], function() {
  connect.server({
    root: 'app',
    livereload: true,
    port: '4000'
  });
});

gulp.task('compile', ['less','coffee']);
gulp.task('default', ['connect', 'watch']);
gulp.task('watch', function () {
  gulp.watch('./app/coffee/**/*.coffee', ['coffee', 'html']);
  gulp.watch('./app/less/**/*.less', ['less', 'html']);
  gulp.watch('./app/**/*.html', ['html']);
});

gulp.task('html', function(){
  return gulp.src('./app/**/*.html')
            .pipe(connect.reload());
});

gulp.task('coffee', ['coffee-clean'], function(){
  return gulp.src('./app/coffee/**/*.coffee')
            .pipe(coffee({bare: true}).on('error', gutil.log))
            .pipe(gulp.dest('./app/build/js/'))
            .pipe(uglify().on('error', gutil.log))
            .pipe(rename({suffix: '.min'}))
            .pipe(gulp.dest('./app/build/production/js'));
});

gulp.task('coffee-clean', function() {
  // You can use multiple globbing patterns as you would with `gulp.src`
  return gulp.src('./app/build/js/', {read: false})
             .pipe(clean({force: true}));
});

gulp.task('less', ['less-clean'], function(){
  return gulp.src('./app/less/**/style-*.less')
            .pipe(less().on('error', gutil.log))
            .pipe(gulp.dest('./app/build/css/'))
            .pipe(minifyCss().on('error', gutil.log))
            .pipe(rename({suffix: '.min'}))
            .pipe(gulp.dest('./app/build/production/css/'));
});

gulp.task('less-clean', function(cb) {
  // You can use multiple globbing patterns as you would with `gulp.src`
  return gulp.src('./app/build/css/', {read: false})
             .pipe(clean({force: true}));
});