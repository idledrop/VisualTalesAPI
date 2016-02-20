var gulp = require('gulp');
var ts = require('gulp-typescript');
var sass = require('gulp-sass');

var paths = {
  typescript: ['public/app/**/*.ts'],
  appSass: ['public/app/**/*.scss'],
  materialSass: ['node_modules/bootstrap-material-design/sass/**/_*.scss']
}

var tsProject = ts.createProject('tsconfig.json');

gulp.task('typescript', function(){
	var tsResult = tsProject.src()
		.pipe(ts(tsProject));
 
	return tsResult.js.pipe(gulp.dest('./'));
});

gulp.task('app-sass', function(){
  return gulp.src(paths.appSass[0], {base: "./"})
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('./'));
});

gulp.task('material-sass', function(){
  return gulp.src('node_modules/bootstrap-material-design/sass/bootstrap-material-design.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(gulp.dest('vendor/assets/styles'));
});

gulp.task('watch', function(){
	gulp.watch(paths.typescript, ['typescript']);
  gulp.watch(paths.appSass, ['app-sass']);
  gulp.watch(paths.materialSass, ['material-sass']);
});

gulp.task('default', ['typescript', 'app-sass', 'material-sass', 'watch'])