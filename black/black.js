var canvas = document.getElementById("canvas");
canvas.height = window.innerHeight;
canvas.width = window.innerWidth;
var context = canvas.getContext('2d');
var lw = Math.ceil(window.innerWidth / 13);
var man = Math.ceil(window.innerHeight / 18);
var row = new Array(lw),
    position = new Array(lw);
for (var i = 0; i < lw; i++) {
    row[i] = 0;
    position[i] = Math.ceil(Math.random() * man * 2);
}
var bj = 0,
    hgh = 0;
setInterval(function() {
    showText(context);
}, 100);
/*
 *显示字母
 * */
function showText(ctx) {
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    ctx.font = "14px Arial";
    for (var k = 0; k < lw; k++) {
        if (bj >= position[k]) {
            var wz = row[k] - 14 * man;
            var ls = row[k];
            if (wz < window.innerHeight + 2) {
                for (var j = 0; j < man; j++) {
//col[j]=col[j]+14;
                    ls -= 14;
                    if (ls < 0) {
                        break;
                    }
                    ctx.fillStyle = getRandomColor();
                    ctx.fillText(getchar(), k * 14, ls);
                }
                row[k] += 14;
            } else {
                row[k] = 0;
            } //输出完毕
        } //可以更新的元素
    }
    if (bj < man * 2) {
        bj++;
    }
}
/*
 * 产生字符
 * */
function getchar() {
    return String.fromCharCode(65 + Math.ceil(Math.random() * 57));
}
/*
 *产生随机颜色
 * */
function getRandomColor() {
    return '#' +
        (function(color) {
            return (color += '0123456789abcdef' [Math.floor(Math.random() * 16)]) &&
            (color.length == 6) ? color : arguments.callee(color);
        })('');
}
