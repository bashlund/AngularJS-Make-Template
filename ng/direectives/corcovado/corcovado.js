angular.module("NgApp").directive("corcovado", function () {
  "use strict";
  return {
    scope: {
    },
    controller: "corcovadoController",
    templateUrl: "$(DIR)/corcovado.html",
    link: function(scope, element, attrs) {
    }
  };
});
