import $ from 'jquery';

export default class AjaxHeaderHelper {
    static get headers() {
        return {
            contentType: "application/json",
            dataType: "json",
            beforeSend: (jqxhr) => {
                jqxhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
            }
        }
    }
}
