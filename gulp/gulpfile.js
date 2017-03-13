/*
cnpm install --save-dev gulp
cnpm install --save-dev gulp-rev
cnpm install --save-dev gulp-rev-collector
cnpm install --save-dev gulp-asset-rev
cnpm install --save-dev run-sequence
*/
//引入gulp和gulp插件
var gulp = require('gulp'),
    assetRev = require('gulp-asset-rev'),
    runSequence = require('run-sequence'),
    rev = require('gulp-rev'),
    revCollector = require('gulp-rev-collector');

//定义css、js\html源文件路径
var cssSrc = '../doa/css/**/*.css',
    jsSrc = '../doa/js/**/*.js',
	htmlSrc = '../doa/pages/**/*.html',
	imageSrc = '../doa/images/**/**';
	
//为css中引入的图片添加hash编码
gulp.task('processCss', function(){
    return gulp.src(cssSrc)   
      .pipe(assetRev())  
      .pipe(gulp.dest('../dist/css')); 
});

//css生成文件hash编码并生成 rev-manifest.json文件名对照映射
gulp.task('revCss', function(){
    return gulp.src(cssSrc)
        .pipe(rev())
        .pipe(rev.manifest())
        .pipe(gulp.dest('rev/css'));
});



//js生成文件hash编码并生成 rev-manifest.json文件名对照映射
gulp.task('revJs', function(){
    return gulp.src(jsSrc)
        .pipe(rev())
        .pipe(rev.manifest())
        .pipe(gulp.dest('rev/js'));
});

//html生成文件hash编码并生成 rev-manifest.json文件名对照映射
gulp.task('revHtml', function(){
    return gulp.src(htmlSrc)
        .pipe(rev())
        .pipe(rev.manifest())
        .pipe(gulp.dest('rev/html'));
});

gulp.task('copyJs', function(){
    return gulp.src(jsSrc)
        .pipe(gulp.dest('../dist/js'));
});

gulp.task('copyImage', function(){
    return gulp.src(imageSrc)
        .pipe(gulp.dest('../dist/images'));
});

//html替换css、js、html文件版本
gulp.task('processHtml', function () {
    return gulp.src(['rev/**/*.json', '../doa/pages/**/*.html'])
        .pipe(revCollector())
        .pipe(gulp.dest('../dist/pages'));
});

//开发构建
gulp.task('default', function (done) {
    condition = false;
    runSequence(
        ['processCss'],
        ['revCss'],
        ['revJs'],
		['revHtml'],
        ['processHtml'],
		['copyJs'],
		['copyImage'],
        done);
});