import React from 'react';
import Utils from './Utils';
import CircularProgress from 'material-ui/CircularProgress';

import AjaxHeaderHelper from './AjaxHeaderHelper';

export default class BaseComponent extends React.Component {

    static get constructorName() {
        return 'BaseComponent'
    }

    static classNameify(str) {
        return str.replace(/[A-Z]/g, function(letter, index) {
            return index == 0 ? letter.toLowerCase() : '-' + letter.toLowerCase();
        });
    }

    constructor(props) {
        super(props);
        this.bemClass = this.bemClass.bind(this);
        this.formatDateTime = this.formatDateTime.bind(this);
    }

    get ajaxHeaders() {
        return AjaxHeaderHelper.headers;
    }

    get spinner() {
        return <CircularProgress />
    }

    get componentClassName() {
        return BaseComponent.classNameify(this.constructor.constructorName);
    }

    get baseClassName() {
        return this.componentClassName;
    }

    bemClass(be,m) {
        return Utils.bemClass(this.baseClassName,be,m)
    }

    formatDateTime(dateTime) {
        return Utils.formatDateTime(dateTime);
    }



}
