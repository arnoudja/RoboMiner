function openUrl(url) {
    try {
        window.location.replace(url);
    }
    catch (e) {}
}

function countdownTimer(seconds, updateFunction, completedFunction)
{
    var startTime = new Date().getTime();
    var interval = setInterval(function() {
        var secondsLeft = (startTime - new Date().getTime()) / 1000 + seconds;
        if (secondsLeft > 0)
        {
            updateFunction(secondsLeft);
        }
        else
        {
            clearInterval(interval);
            completedFunction();
        }
    }, 200);
}

function formatTimeLeft(seconds)
{
    var secondsLeft = Math.floor(seconds) % 60;
    var minutesLeft = Math.floor(seconds / 60) % 60;
    var hoursLeft   = Math.floor(seconds / 3600);
    
    var result = hoursLeft > 0 ? hoursLeft + ':' : '';
    
    if (minutesLeft < 10 && hoursLeft > 0)
    {
        result = result + '0';
    }
    
    result = result + minutesLeft + ':';
    
    if (secondsLeft < 10)
    {
        result = result + '0';
    }
    
    result = result + secondsLeft;
    
    return result;
}

function showPart(itemId) {
    document.getElementById(itemId).style.display = 'inherit';
}

function hidePart(itemId) {
    document.getElementById(itemId).style.display = 'none';
}

function showElements(elements) {
    for (var i = 0; i < elements.length; i++) {
        elements[i].style.display = 'inherit';
    }
}

function hideElements(elements) {
    for (var i = 0; i < elements.length; i++) {
        elements[i].style.display = 'none';
    }
}

function updateDisplayStyle(elements, value) {
    for (var i = 0; i < elements.length; i++) {
        elements[i].style.display = value;
    }
}

function htmlDecode(encodedText) {
    var element = document.createElement('div');
    element.innerHTML = encodedText;
    return element.childNodes.length === 0 ? "" : element.childNodes[0].nodeValue;
}

function processTab(event, element) {

    if (event.keyCode === 9) {

        var value = element.value;
        var start = element.selectionStart;
        var end = element.selectionEnd;

        var linestart = start;
        while (linestart > 0 && value[linestart - 1] !== '\n') --linestart;

        if (start === end) {

            var spaces = 4 - (start - linestart) % 4;

            for (i = 0; i < spaces; ++i) {
                value = value.substring(0, start) + ' ' + value.substring(end);
                ++start;
                ++end;
            }

            element.value = value;
            element.selectionStart = element.selectionEnd = start;
        }
        else {

            if (!event.shiftKey) {

                for (i = end - 1; i >= linestart; --i) {
                    if (value[i - 1] === '\n') {
                        value = value.substring(0, i) + "    " + value.substring(i);
                        end += 4;
                    }
                }

                if (start > linestart) {
                    start += 4;
                }
            }
            else {

                for (i = end - 1; i >= linestart; --i) {
                    if (value[i - 1] === '\n') {
                        for (j = 0; j < 4; ++j) {
                            if (value[i] === ' ') {
                                
                                value = value.substring(0, i) + value.substring(i + 1);
                                --end;

                                if (i < start) {
                                    --start;
                                }
                            }
                        }
                    }
                }
            }

            element.value = value;
            element.selectionStart = start;
            element.selectionEnd = end;
        }
        
        return false;
    }
    
    return true;
}