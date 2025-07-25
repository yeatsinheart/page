//1、urltoImage(url,fn) 会通过一个url加载所需要的图片对象，
// 其中url参数传入图片的url,fn为回调方法,包含一个Image对象的参数，代码如下：
function urltoImage(url, fn) {
    var img = new Image();
    img.src = url;
    img.onload = function () {
        fn(img);
    }
}

//复制代码2、imagetoCanvas(image)
// 将一个Image对象转变为一个Canvas类型对象，其中image参数传入一个Image对象，代码如下：
function imagetoCanvas(image, maxwidth) {
    var cvs = document.createElement("canvas");
    var ctx = cvs.getContext('2d');
    // 等比例缩放
    cvs.width = image.width;
    cvs.height = image.height;
    // 等比例缩小
    if (image.width > maxwidth) {
        let rad = image.width / maxwidth;
        cvs.width = image.width / rad;
        cvs.height = image.height / rad;
    }
    /*if(cvs.height>maxwidth){
        let rad = cvs.height / maxwidth;
        cvs.width = cvs.width / rad;
        cvs.height = cvs.height / rad;
    }*/

    ctx.drawImage(image, 0, 0, cvs.width, cvs.height);
    // 将canvas的透明背景设置成白色
    var imageData = ctx.getImageData(0, 0, cvs.width, cvs.height);
    for (var i = 0; i < imageData.data.length; i += 4) {
        // 当该像素是透明的，则设置成白色
        if (imageData.data[i + 3] == 0) {
            imageData.data[i] = 255;
            imageData.data[i + 1] = 255;
            imageData.data[i + 2] = 255;
            imageData.data[i + 3] = 255;
        }
    }
    ctx.putImageData(imageData, 0, 0);
    return cvs;
}

//3、canvasResizetoFile(canvas,quality,fn)会
// 将一个Canvas对象压缩转变为一个Blob类型对象；
// 其中canvas参数传入一个Canvas对象;
// quality参数传入一个0-1的number类型，表示图片压缩质量;
// fn为回调方法，包含一个Blob对象的参数;代码如下：
function canvasResizetoFile(canvas, maxWidth, maxSize, quality, fn, times) {
    canvas.toBlob(function (blob) {
        if (times) {
            times = parseInt(times) + 1
        } else {
            times = 1
        }
        if ((blob.size / 1024) > maxSize && times < 10) {
            quality = quality - 0.1
            quality = quality > 0 ? quality : 0.1
            fileResizetoFile(blob, maxWidth, maxSize, quality, fn, times)
        } else {
            fn(blob);
        }
    }, 'image/jpeg', quality);
}

//4、canvasResizetoDataURL(canvas,quality) 会
// 将一个Canvas对象压缩转变为一个dataURL字符串,
// 其中canvas参数传入一个Canvas对象;
// quality参数传入一个0-1的number类型，表示图片压缩质量;代码如下：
function canvasResizetoDataURL(canvas, maxWidth, maxSize, quality, fn, times) {
    let base64 = canvas.toDataURL('image/jpeg', quality);
    if (times) {
        times = parseInt(times) + 1
    } else {
        times = 1
    }
    if ((base64.size / 1024) > maxSize && times < 10) {
        quality = quality - 0.1
        quality = quality > 0 ? quality : 0.1
        fileResizetoFile(blob, maxWidth, maxSize, quality, fn, times)
    } else {
        fn(blob);
    }

}

//5、filetoDataURL(file,fn)
// 会将 File（Blob）类型文件转变为dataURL字符串,
// 其中 file 参数传入一个File（Blob）类型文件;fn为回调方法，包含一个dataURL字符串的参数;代码如下：
function filetoDataURL(file, fn) {
    var reader = new FileReader();
    reader.onloadend = function (e) {
        fn(e.target.result.replace("data:application/octet-stream;", "data:image/jpeg;"));
    };
    reader.readAsDataURL(file);
}

//6、dataURLtoImage(dataurl,fn) 会
// 将一串dataURL字符串转变为Image类型文件,
// 其中dataurl参数传入一个dataURL字符串,fn为回调方法，包含一个Image类型文件的参数，代码如下：
function dataURLtoImage(dataurl, fn) {
    var img = new Image();
    img.onload = function () {
        fn(img);
    };
    img.src = dataurl;
}

//7、dataURLtoFile(dataurl) 会
// 将一串dataURL字符串转变为Blob类型对象，其中dataurl参数传入一个dataURL字符串,代码如下：
function dataURLtoFile(dataurl) {
    var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
        bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);
    while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], {type: mime});
}

//8。将一个File对象压缩之后再变为File对象,我们可以将上面的方法再封装一下，参考如下代码：
function fileResizetoFile(file, maxWidth, maxSize, quality, fn, times) {
    console.log(file.size / 1000, "kb", quality, times)
    filetoDataURL(file, function (dataurl) {
        dataURLtoImage(dataurl, function (image) {
            canvasResizetoFile(imagetoCanvas(image, maxWidth), maxWidth, maxSize, quality, fn, times);
        })
    })
}
