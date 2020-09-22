// Remark macros

remark.macros.scaleSVG = function (scale) {
  var url = this;
  return '<img src="' + url + '" style="transform: scale(' + scale + ')" />';
};

remark.macros.img = function (width) {
  var url = this;
  return '<img src="' + url + '" style="width: ' + width + '" />';
};

remark.macros.font = function (size) {
  var text = this;
  return '<div style="font-size: ' + size + '">' + text + '</div>';
};

remark.macros.TODO = function () {
  var text= this;
  return '<span class="TODO">TODO: ' + text + '</span>';
};

remark.macros.vspace = function (height) {
  return '<span style="display: block; height: ' + height +'"></span>';
};

remark.macros.hspace = function (width) {
  return '<span style="display: inline-block; width: ' + width +'"></span>';
};