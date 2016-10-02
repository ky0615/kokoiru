angular.module("templates", []).run(["$templateCache", function($templateCache) {$templateCache.put("templates/error.html","<div id=\"main\">\n  <header id=\"header\" class=\"\">\n    <h1>{{text}}</h1>\n  </header>\n</div>\n");
$templateCache.put("templates/index.html","<div id=\"main toast-container\">\n  <header class=\"header\">\n    <h1>User List</h1>\n  </header>\n  <md-list id=\"userList\">\n      <md-list-item\n          ng-repeat=\"(key, value) in users\"\n          ng-class=\"{now: !value.leftFlag}\"\n          class=\"userContent\">\n          <!-- <pre>{{value|json}}</pre> -->\n          <md-icon aria-label=\"user icon\" ng-class=\"{enableIcon: !value.leftFlag}\" class=\"md-avatar-icon\">person</md-icon>\n          <p class=\"userName\">\n               {{value.number}}<br>{{value.name}}\n          </p>\n          <p class=\"md-secondary\">\n            <span ng-show=\"value.leftFlag\">{{value.leftAt | diffTime}}</span>\n            <span ng-show=\"!value.leftFlag\">いる(かも)</span>\n          </p>\n          <md-menu class=\"md-secondary\">\n            <md-button aria-label=\"Open user menu\" class=\"md-icon-button\" ng-click=\"openMenu($mdOpenMenu, $event)\">\n              <md-icon>menu</md-icon>\n            </md-button>\n            <md-menu-content width=\"8\">\n              <md-menu-item>\n                <md-button ng-click=\"switchAttend(value)\">\n                  <md-icon md-menu-align-target>exit_to_app</md-icon>\n                  入退出する\n                </md-button>\n              </md-menu-item>\n            </md-menu-content>\n          </md-menu>\n          <md-divider />\n      </md-list-item>\n  </md-list>\n</div>\n");
$templateCache.put("templates/main.html","<div ui-view></div>\n");
$templateCache.put("templates/message.html","<md-content>\n  <section layout=\"row\" layout-sm=\"column\" layout-wrap>\n    aaa\n  </section>\n  <section layout=\"row\" layout-sm=\"column\" layout-wrap>\n    aaa\n  </section>\n</md-content>");
$templateCache.put("templates/scan.html","<md-content>\n  <section layout=\"row\" layout-sm=\"column\" layout-wrap>\n    <md-button class=\"md-raised md-primary\" ng-click=\"scan()\">Scan</md-button>\n    <md-button class=\"md-raised md-primary\" ng-click=\"send()\">Test</md-button>\n    <md-button class=\"md-raised md-primary\" ng-click=\"save($event)\">保存</md-button>\n  </section>\n  <section layout=\"row\" layout-sm=\"column\" layout-wrap>\n    <pre>{{result}}</pre>\n  </section>\n</md-content>");
$templateCache.put("templates/send.html","<div ng-show=\"!isUuid()\">\n  <p>メニューから送信するものを選んでください。</p>\n</div>\n\n<div ng-show=\"data\">\n  <h1>{{data.name}}</h1>\n  <md-content>\n    <section layout=\"row\" layout-sm=\"column\" layout-wrap>\n      <md-button class=\"md-raised md-primary\" ng-click=\"send()\">送信</md-button>\n      <md-button class=\"md-raised md-primary\" ng-click=\"remove($event)\">削除</md-button>\n    </section>\n    <section layout=\"row\" layout-sm=\"column\" layout-wrap>\n      <pre>{{data.data}}</pre>\n    </section>\n  </md-content>\n</div>");}]);