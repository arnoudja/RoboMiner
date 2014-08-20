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
    document.getElementById(itemId).style = '';
}

function hidePart(itemId) {
    document.getElementById(itemId).style = 'display: none';
}

function showElements(elements) {
    for (var i = 0; i < elements.length; i++) {
        elements[i].style = '';
    }
}

function hideElements(elements) {
    for (var i = 0; i < elements.length; i++) {
        elements[i].style = 'display: none';
    }
}

function htmlDecode(encodedText) {
  var element = document.createElement('div');
  element.innerHTML = encodedText;
  return element.childNodes.length === 0 ? "" : element.childNodes[0].nodeValue;
}
