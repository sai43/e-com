export default class Utils {

    static setSelection(currentSelection, idx, event) {
        let newSelection = currentSelection || [];
        if (event.metaKey) {
            let alreadySelected = newSelection.indexOf(idx);
            if (alreadySelected >= 0) {
                newSelection.splice(alreadySelected, 1);
            } else {
                newSelection.push(idx);
            }
        } else if (event.shiftKey) {
            // Select all items between last/first and current
            const min = Math.min(...newSelection)
            const max = Math.max(...newSelection)
            if (idx < max) {
                for (let i=idx;i<max;i++) {
                    if (newSelection.indexOf(i) < 0) {
                        newSelection.push(i);
                    }
                }
            }
            if (idx > min) {
                for (let i=min+1;i<=idx;i++) {
                    if (newSelection.indexOf(i) < 0) {
                        newSelection.push(i);
                    }
                }
            }
        } else {
            newSelection = [idx];
            if (Utils.arraysEqual(newSelection, currentSelection)) {
                newSelection = [];
            }
        }
        return newSelection;
    }


    static fakeNavigate(path) {
        window.history.pushState({},'',path)
    }


    static formatDateTime(dateTime) {
        try {
            if (typeof(dateTime) === "string") {
                dateTime = new Date(dateTime)
            }
            return dateTime.toLocaleString();
        } catch(err) {
            console.log(err)
            return dateTime;
        }
    }

    static navigate(url, event) {
        if (event)
            event.stopPropagation();
        if (event && (event.metaKey || event.ctrlKey)) {
            //open in new tab
            window.open(url);
        } else {
            window.location.href = url;
        }
    }

    static flattenDeep(arr1) {
        return arr1.reduce((acc, val) => Array.isArray(val) ? acc.concat(Utils.flattenDeep(val)) : acc.concat(val), []);
    }

    static arraysEqual(arr1, arr2) {
        if(arr1.length !== arr2.length)
            return false;
        for(var i = arr1.length; i--;) {
            if(arr1[i] !== arr2[i])
                return false;
        }
        return true;
    }


    static bemClass(baseClassName,be,modifiers) {
        if (typeof(be)=="string") {
            be = [be]
        }
        if (be == null) {
            be = [];
        }
        if (modifiers) {
            modifiers = Utils.flattenDeep([modifiers])
        }
        let bem = baseClassName;
        if (be.length > 0) {
            bem = `${bem}__${be.join("__")}`
        }
        if (modifiers) {
            let modifiedBem = bem;
            for (let m of modifiers) {
                modifiedBem = `${modifiedBem} ${bem}--${m}`;
            }
            bem = modifiedBem;
        }
        return bem;

    }

}

window.Utils = Utils;