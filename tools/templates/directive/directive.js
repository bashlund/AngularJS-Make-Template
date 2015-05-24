angular.module("ModuleName").directive("directiveName", function () {
  "use strict";
  return {
    scope: {
    },
    controller: "directiveNameController",
    templateUrl: "$(DIR)/directiveName.html",
    link: function(scope, element, attrs) {
    }
  };
});
