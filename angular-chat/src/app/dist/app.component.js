"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
exports.__esModule = true;
exports.AppComponent = void 0;
var core_1 = require("@angular/core");
var pusher_js_1 = require("pusher-js");
var AppComponent = /** @class */ (function () {
    function AppComponent(http) {
        this.http = http;
        this.username = 'username';
        this.message = '';
        this.messages = [];
    }
    AppComponent.prototype.ngOnInit = function () {
        var _this = this;
        // Enable pusher logging - don't include this in production
        pusher_js_1["default"].logToConsole = true;
        var pusher = new pusher_js_1["default"]('5e8ceb2bfcbc047fe040', {
            cluster: 'us2'
        });
        var channel = pusher.subscribe('chat');
        channel.bind('message', function (data) {
            _this.messages.push(data);
        });
    };
    AppComponent.prototype.submit = function () {
        var _this = this;
        this.http.post('http://localhost:8000/api/messages', {
            username: this.username,
            message: this.message
        }).subscribe(function () { return _this.message = ''; });
    };
    AppComponent = __decorate([
        core_1.Component({
            selector: 'app-root',
            templateUrl: './app.component.html',
            styleUrls: ['./app.component.css']
        })
    ], AppComponent);
    return AppComponent;
}());
exports.AppComponent = AppComponent;
