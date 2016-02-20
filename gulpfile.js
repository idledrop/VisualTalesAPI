var gulp = require('gulp');
var ts = require('gulp-typescript');
var sass = require('gulp-sass');

var paths = {
  typescript: ['public/app/**/*.ts'],
  sass: ['public/app/**/*.scss']
}

var tsProject = ts.createProject('tsconfig.json');

gulp.task('typescript', function(){
	var tsResult = tsProject.src()
		.pipe(ts(tsProject));
 
	return tsResult.js.pipe(gulp.dest('./'));
});

gulp.task('sass', function(){
  return gulp.src('public/app/**/*.scss', {base: "./"})
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./'));
});

gulp.task('watch', function(){
	gulp.watch(paths.typescript, ['typescript']);
  gulp.watch(paths.sass[0], ['sass']);
});

gulp.task('default', ['typescript', 'sass', 'watch'])