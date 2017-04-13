
var FILTER_FIELD_PLACEHOLDER = 'Select field to filter on';
var FILTER_FIELD_EMPTY_PLACEHOLDER = 'No more fields';
var FILTER_VALUE_PLACEHOLDER = '+ Add values';
var FILTER_VALUE_MORE_PLACEHOLDER = '+ Add more values';
var FILTER_VALUE_EMPTY_PLACEHOLDER = 'No more values';

var oppAmountFields;
var oppFilterFields;
var selectedAmountField;
var selectedFilters;
var filterValueDataCache;

var filterFieldInputSelections = {};
var filterValueInputData = {};
var filterValueBoxItems = {};

var openAmountFieldInput = false;

$j(document).ready(function() {
    loadData();

    $j.address.change(function(event) {
        if (location.hash && location.hash != '#') {
            showView($j(location.hash.replace('view','')));
        }
        else {
            showView($j('.splash'));
        }
    });

    fixAutcompleteHTMLRendering();
    addFilterHandler();
    addAutocompleteToAmountField();
    addExistingFilters();

    $j('.splash .warning_container .warning_box .warning_btn_box .warning_btn').click(function() {
        openAmountFieldInput = true;
        $j('.splash .warning_container').remove();
    });

    var bgVideoLoaded = false;
    var dealVideoLoaded = false;

    function checkVideosDoneLoading() {
        if (bgVideoLoaded && dealVideoLoaded) {
            $j.cookie("videosLoaded", "yes");
        }
    }

    $j('.preload_container .bg_video').on('canplaythrough', function() {
        bgVideoLoaded = true;
        checkVideosDoneLoading();
    });

    $j('.preload_container .deal_video').on('canplaythrough', function() {
        dealVideoLoaded = true;
        checkVideosDoneLoading();
    });
});

function loadData() {
    loadAmountFields();
    loadFilterFields();
    loadSelectedAmountField();
    loadSelectedFilters();
    loadFilterValueDataCache();
}

function loadAmountFields() {
    oppAmountFields = [];
    $j('.opp_amount_field').each(function(index, elem) {
        oppAmountFields.push(createAutocompleteItem(elem));
    });
}

function loadFilterFields() {
    oppFilterFields = [];
    $j('.opp_filter_field').each(function(index, elem) {
        oppFilterFields.push(createAutocompleteItem(elem));
    });
}

function loadSelectedAmountField() {
    selectedAmountField = createAutocompleteItem($j('.selected_amount_field')[0]);
}

function loadSelectedFilters() {
    selectedFilters = [];
    $j('.selected_filter_field').each(function(index, elem) {
        var filterValues = [];
        $j(elem).children('.selected_filter_value').each(function(index, valElem) {
            filterValues.push(createAutocompleteItem(valElem));
        });
        selectedFilters.push({field:createAutocompleteItem(elem), filters:filterValues});
    });
}

function loadFilterValueDataCache() {
    filterValueDataCache = {};
    $j('.filter_value_cache_item').each(function(index, elem) {
        var cacheKey = $j(elem).children('.cache_key').text();
        filterValueDataCache[cacheKey] = new Array();
        $j(elem).children('.filter_value_cache_val').each(function(index, valElem) {
            filterValueDataCache[cacheKey].push(createAutocompleteItem(valElem));
        });
    });
}

function createAutocompleteItem(elem) {
    var $elem = $j(elem);
    return {
        name: $elem.children('.name').text(),
        label: $elem.children('.label').text(),
        sortkey: $elem.children('.sortkey').text(),
    };
}

function showView($view) {
    if ($j('.view').is(':visible')) {
        $j('.view:visible').hide(0, function() {
            $j('.option_input').blur();
            $view.fadeIn(300, function() {
                if ($j('.config').is(':visible')) {
                    var $amountFieldInput = $j('.amount_field_input');
                    $amountFieldInput.focus();
                    if (openAmountFieldInput) {
                        openAmountFieldInput = false;
                        $amountFieldInput.trigger('click');
                    }
                }
            });
        });
    }
    else {
        $view.show();
    }
}

function fixAutcompleteHTMLRendering() {
    $j[ "ui" ][ "autocomplete" ].prototype["_renderItem"] = function( ul, item) {
        return $j( "<li></li>" )
            .data( "item.autocomplete", item )
            .append( $j( "<a></a>" ).html( item.label ) )
            .appendTo( ul );
    };
}

//
// SELECT AMOUNT FIELD
//

function addAutocompleteToAmountField() {
    attachAutocomplete(
        $j('.amount_field_input'),
        oppAmountFields,
        amountFieldAutocompleteSelect,
        amountFieldAutocompleteCreate,
        amountFieldAutocompleteSearch
    );
}

function amountFieldAutocompleteCreate(event, ui) {
    selectCurrentAmountField();
}

function amountFieldAutocompleteSelect(event, ui) {
    var $amountFieldInput = $j(event.target);
    var ignoreCurrentValue = $amountFieldInput.hasClass('invalid');

    $amountFieldInput.removeClass('invalid');
    $amountFieldInput.next('.error').hide();

    selectAmountField(ui.item, ignoreCurrentValue);
}

function amountFieldAutocompleteSearch(event, ui) {
    if (selectedAmountField != null && $j(event.target).val() != selectedAmountField.label) {
        addAutocompleteItem(selectedAmountField, oppAmountFields);
        selectedAmountField = null;
    }
}

function selectCurrentAmountField() {
    var $amountFieldInput = $j('.amount_field_input');

    if (selectedAmountField != null && selectedAmountField.label != '') {
        if (invalidField(selectedAmountField, oppAmountFields)) {
            $amountFieldInput.addClass('invalid');
            $amountFieldInput.next('.error').show();
        }
        $amountFieldInput.val(selectedAmountField.label);
        removeAutocompleteItem(selectedAmountField, oppAmountFields);
    }
    sortAutocompleteData(oppAmountFields);
}

function selectAmountField(fieldItem, ignoreCurrentValue) {
    removeAutocompleteItem(fieldItem, oppAmountFields);
    if (!ignoreCurrentValue) {
        addAutocompleteItem(selectedAmountField, oppAmountFields);
    }

    selectedAmountField = fieldItem;
    var newLabel = '';
    if (selectedAmountField) {
        newLabel = selectedAmountField.label;
    }
    $j('.amount_field_input').val(newLabel);

    // in some strange corner case the selected value gets cleared;
    // I have spent 2 days trying to figure this out;
    // screw it, I'm going to hack a fix
    for (var i=0; i<500; i+=20) {
        setTimeout(function() {
            $j('.amount_field_input').val(newLabel);
        },i);
    }
}

//
// + ADD FILTER
//

function addFilterHandler() {
    $j('.add_filter_btn').click(function() {
        if (!$j(this).hasClass('disabled')) {
            addFilterOptionToDOM();
        }
    });
}

function addExistingFilters() {
    $j('.filter_option').each(function(index, elem) {
        deleteFilterOption($j(elem));
    });

    for (var i=0; i < selectedFilters.length; i++) {
        var filter = selectedFilters[i];
        if (filter.filters.length > 0) {
            var $filterOption = addFilterOptionToDOM(filter.field);
            var $filterValueInput = $filterOption.find('.filter_value_input');

            for (var j=0; j < filter.filters.length; j++) {
                var filterValue = filter.filters[j];
                selectFilterValue($filterValueInput, filterValue);
            }
        }
    }
    sortAutocompleteData(oppFilterFields);
}

function addFilterOptionToDOM(field) {
    var firstFilter = $j('.filter_options').children().length == 0;
    $j('.filter_options').append(getFilterOptionHTML(firstFilter));

    var $filterOption = $j('.filter_options .filter_option:last');
    var $filterOptionDel = $filterOption.find('.filter_option_del');
    var $filterFieldInput = $filterOption.find('.filter_field_input');
    var $filterValueInput = $filterOption.find('.filter_value_input');

    deleteFilterOptionHandler($filterOptionDel);
    addAutocompleteToFilterField($filterFieldInput);

    $filterValueInput.click(function(e) {
        var $filterValueInput = $j(e.target);
        var $filterValuesBox = $j(e.target).parents('.filter_values_box');

        if ($filterValueInput.hasClass('disabled') || $filterValuesBox.hasClass('disabled') || $filterValueInput.attr('disabled')) {
            $filterValueInput.blur();
            $filterValuesBox.blur();
            e.preventDefault();
            return false;
        }
        else {
            $filterValuesBox.addClass('focus');
            $filterValueInput.focus();
        }
    }).blur(function(e) {
        var $filterValueInput = $j(e.target);
        var $filterValuesBox = $j(e.target).parents('.filter_values_box');

        if (!$filterValueInput.hasClass('disabled') && !$filterValuesBox.hasClass('disabled')) {
            $filterValuesBox.removeClass('focus');
        }
    });

    if (field) {
        $filterOption.attr('id', field.name+'FilterOptionFieldId');
        selectFilterField($j('.filter_option:last .filter_field_input'), field, true);
    }
    else if (oppFilterFields.length > 0) {
        $filterFieldInput.trigger('click');
        $filterFieldInput.focus();
    }

    if (oppFilterFields.length == 0) {
        var $filterFieldInputs = $j('.config .filter_field_input');
        $filterFieldInputs.prop('disabled', true);
        $filterFieldInputs.attr('placeholder', FILTER_FIELD_EMPTY_PLACEHOLDER);
    }

    return $filterOption;
}

function getFilterOptionHTML(first) {
    var html = ''
    if (!first) {
        html += '<span class="filter_option_divider">and</span>'
    }
    var filterFieldPlaceholder = FILTER_FIELD_PLACEHOLDER;
    if (oppFilterFields.length == 0) {
        filterFieldPlaceholder = FILTER_FIELD_EMPTY_PLACEHOLDER;
    }
    html += ' \
      <div class="option filter_option"> \
        <img class="filter_option_del" src="'+DELETE_BUTTON_URL+'"/> \
        <div class="input_box"> \
          <span class="option_label">Field</span> \
          <input class="option_input filter_field_input" placeholder="'+filterFieldPlaceholder+'"/> \
          <span class="error">Invalid field</span> \
        </div> \
        <div class="input_box"> \
          <span class="option_label filter_label disabled">Include</span> \
          <div class="filter_values_box option_input disabled"> \
            <input class="filter_value_input" placeholder="'+FILTER_VALUE_PLACEHOLDER+'"/> \
          </div> \
        </div> \
      </div>';

    return html;
}

function deleteFilterOptionHandler($filterOptionDel) {
    $filterOptionDel.click(function(e) {
        deleteFilterOption($j(e.target).parent());
    });
}

function deleteFilterOption($filterOption) {
    var $firstOption = $j('.filter_options .filter_option:first');
    var $filterFieldInput = $filterOption.find('.filter_field_input');

    $filterOption.find('.filter_value_box').each(function(index, value) {
        deleteFilterValueBox($j(value));
    });

    if ($filterOption.attr('id')) {
        var fieldName = $filterOption.attr('id').replace('FilterOptionFieldId','');
        addAutocompleteItem(filterFieldInputSelections[$filterFieldInput.attr('id')], oppFilterFields);
        delete filterFieldInputSelections[$filterFieldInput.attr('id')];

        removeFromArray(fieldName, selectedFilters, function(a,b) {
            return a == b.field.name;
        });
    }

    if (oppFilterFields.length > 0) {
        var $filterFieldInputs = $j('.config .filter_field_input');
        $j('.config .filter_field_input').prop('disabled', false);
        $j('.config .filter_field_input').attr('placeholder', FILTER_FIELD_PLACEHOLDER);
    }

    if ($filterOption.attr('id') == $firstOption.attr('id')) {
        $filterOption.next('.filter_option_divider').remove();
    }
    else {
        $filterOption.prev('.filter_option_divider').remove();
    }
    $filterOption.remove();
}

//
// SELECT FILTER FIELD
//

function addAutocompleteToFilterField($input) {
    attachAutocomplete(
        $input,
        oppFilterFields,
        filterFieldAutocompleteSelect,
        null,
        filterFieldAutocompleteSearch
    );
}

function filterFieldAutocompleteSelect(event, ui) {
    var $filterFieldInput = $j(event.target);

    $filterFieldInput.parents('.option').find('.filter_value_box').each(function(index, value) {
        deleteFilterValueBox($j(value));
    });

    selectFilterField($filterFieldInput, ui.item);
    selectedFilters.push({field: ui.item, filters: []});

    return true;
}

function filterFieldAutocompleteSearch(event, ui) {
    var $input = $j(event.target);
    var selectedFilterField = filterFieldInputSelections[$input.uniqueId().attr('id')];

    if (selectedFilterField && $input.val() != selectedFilterField.label) {
        addAutocompleteItem(filterFieldInputSelections[$input.attr('id')], oppFilterFields);
        delete filterFieldInputSelections[$input.attr('id')];
    }
}

function selectFilterField($filterFieldInput, field, populating) {
    var invalidFilterField = invalidField(field, oppFilterFields);
    if (invalidFilterField) {
        $filterFieldInput.addClass('invalid');
        $filterFieldInput.next('.error').show();
    }
    else {
        $filterFieldInput.removeClass('invalid');
        $filterFieldInput.next('.error').hide();
    }

    removeAutocompleteItem(field, oppFilterFields);
    if (filterFieldInputSelections[$filterFieldInput.attr('id')]) {
        addAutocompleteItem(filterFieldInputSelections[$filterFieldInput.attr('id')], oppFilterFields);
    }
    if (oppFilterFields.length == 0) {
        var $filterFieldInputs = $j('.config .filter_field_input');
        $filterFieldInputs.prop('disabled', true);
        $filterFieldInputs.attr('placeholder', FILTER_FIELD_EMPTY_PLACEHOLDER);
    }

    if (!invalidFilterField) {
        filterFieldInputSelections[$filterFieldInput.uniqueId().attr('id')] = field;
    }

    $filterFieldInput.parents('.option').attr('id', field.name+'FilterOptionFieldId');
    $filterFieldInput.val(field.label);

    getPicklistValues(field.name, populating);

    // in some strange corner case the selected value gets cleared;
    // I have spent 2 days trying to figure this out;
    // screw it, I'm going to hack a fix
    for (var i=0; i<500; i+=20) {
        setTimeout(function() {
            $filterFieldInput.val(field.label);
        },i);
    }
}

function getPicklistValues(fieldName, populating) {
    if (filterValueDataCache[fieldName]) {
        setupFilterValuesInput(fieldName, filterValueDataCache[fieldName], populating);
    }
    else {
        var $filterValuesBox = $j('.filter_option#'+fieldName+'FilterOptionFieldId .filter_values_box');
        $filterValuesBox.addClass('loading_picklist');

        Visualforce.remoting.Manager.invokeAction(
            REMOTE_GET_FILTER_OPTIONS_METHOD,
            fieldName,
            getPicklistValuesResponse
        );
    }
}

function getPicklistValuesResponse(result, event) {
    if (event.status) {
        var fieldName = result[0].fieldName;
        result.splice(0,1);
        setupFilterValuesInput(fieldName, result);
        filterValueDataCache[fieldName] = result;

        var $filterValuesBox = $j('.filter_option#'+fieldName+'FilterOptionFieldId .filter_values_box');
        $filterValuesBox.removeClass('loading_picklist');
    }
    else if (event.type === 'exception') {
        location.reload();
    }
    else {
        $j('.warning_modal.unknown_error').fadeIn();
        $j('.view.config').addClass('modal_open');

        $j('.warning_modal.unknown_error .warning_close_btn').click(function() {
            $j('.warning_modal.unknown_error').fadeOut(300, function() {
                $j('.view.config').removeClass('modal_open');
            });
        });

        $j('.warning_modal.unknown_error .warning_btn').click(function() {
            $j('.warning_modal.unknown_error').fadeOut(300, function() {
                $j('.view.config').removeClass('modal_open');
            });
        });
    }
}

function setupFilterValuesInput(fieldName, filterValues, populating) {
    var $filterOption = $j('.filter_option#'+fieldName+'FilterOptionFieldId');
    var $filterValueInputLabel = $filterOption.find('.filter_label');
    var $filterValuesBox = $filterOption.find('.filter_values_box');
    var $filterValueInput = $filterOption.find('.filter_value_input');

    $filterValuesBox.click(function(e) {
        $j(e.target).find('.filter_value_input').trigger('click');
    });

    addAutocompleteToFilterValueInput($filterValueInput, filterValues);
    $filterValueInputLabel.removeClass('disabled');
    $filterValuesBox.removeClass('disabled');

    if (!populating) {
        $filterValueInput.trigger('click');
        $filterValueInput.focus();
    }
}

//
// SELECT FILTER VALUE
//

function addAutocompleteToFilterValueInput($filterValueInput, data) {
    attachAutocomplete(
        $filterValueInput,
        data,
        filterValueAutocompleteSelect
    );
    filterValueInputData[$filterValueInput.uniqueId().attr('id')] = data;
}

function filterValueAutocompleteSelect(event, ui) {
    var $filterValueInput = $j(event.target);
    selectFilterValue($filterValueInput, ui.item);

    var fieldName = $filterValueInput.parents('.filter_option').attr('id').replace('FilterOptionFieldId','');
    for (var i=0; i < selectedFilters.length; i++) {
        var filter = selectedFilters[i];
        if (filter.field.name == fieldName) {
            selectedFilters[i].filters.push(ui.item);
            break;
        }
    }

    $filterValueInput.val('');
    return false;
}

function selectFilterValue($filterValueInput, filter) {
    removeAutocompleteItem(filter, filterValueInputData[$filterValueInput.attr('id')]);
    addFilterValueToDOM($filterValueInput, filter);
    setFilterValueInputStatus($filterValueInput);
}

function addFilterValueToDOM($filterValueInput, filter) {
    $filterValueInput.before(getFilterValueBoxHTML(filter.label));

    var $filterValueBox = $filterValueInput.prev();
    var $filterValueDeleteButton = $filterValueBox.find('.filter_value_del');

    deleteFilterValueHandler($filterValueDeleteButton);
    filterValueBoxItems[$filterValueBox.uniqueId().attr('id')] = filter;

    $filterValueDeleteButton.hover(function(e) {
        var $filterValueDeleteButton = $j(e.target);
        $filterValueDeleteButton.parent().addClass('del_hover');
        $filterValueDeleteButton.prev().addClass('del_hover');
    }, function(e) {
        $j(e.target).parent().removeClass('del_hover');
        $filterValueDeleteButton.prev().removeClass('del_hover');
    });
}

function getFilterValueBoxHTML(filterLabel) {
    return ' \
      <div class="filter_value_box"> \
        <span class="filter_value">'+filterLabel+'</span> \
        <span class="filter_value_del"></span> \
      </div>';
}

function deleteFilterValueHandler($elem) {
    $elem.click(function(e) {
        deleteFilterValueBox($j(e.target).parent());
    });
}

function deleteFilterValueBox($filterValueBox) {
    var $filterOption = $filterValueBox.parents('.filter_option');
    var $filterValueInput = $filterOption.find('.filter_value_input');
    var filterFieldName = $filterOption.attr('id').replace('FilterOptionFieldId','');
    var filterValueItem = filterValueBoxItems[$filterValueBox.attr('id')];
    var filterValueData = filterValueInputData[$filterValueInput.attr('id')];

    addAutocompleteItem(filterValueItem, filterValueData);

    if ($filterValueBox.siblings('.filter_value_box').length == 0) {
        var $activeFiltersLabel = $filterValueInput.parent().find('.active_filters_label');
        $activeFiltersLabel.removeClass('visible');
    }

    for (var i=0; i < selectedFilters.length; i++) {
        var filter = selectedFilters[i];
        if (filter.field.name == filterFieldName) {
            removeFromArray(filterValueItem, selectedFilters[i].filters, function(a,b) {
                return a.name == b.name;
            });
        }
    }

    delete filterValueBoxItems[$filterValueBox.attr('id')];
    $filterValueBox.remove();
    setFilterValueInputStatus($filterValueInput);
}

function setFilterValueInputStatus($filterValueInput) {
    var $filterValuesBox = $filterValueInput.parents('.filter_values_box');
    var numFilterValuesLeft = filterValueInputData[$filterValueInput.attr('id')].length;
    var numFilterValuesUsed = $filterValuesBox.find('.filter_value_box').length;

    if (numFilterValuesLeft == 0) {
        $filterValuesBox.addClass('full');
        $filterValueInput.prop('disabled', true);
        $filterValueInput.attr('placeholder', FILTER_VALUE_EMPTY_PLACEHOLDER);
    }
    else {
        $filterValuesBox.removeClass('disabled');
        $filterValueInput.prop('disabled', false);

        if (numFilterValuesUsed == 0) {
            $filterValueInput.attr('placeholder', FILTER_VALUE_PLACEHOLDER);
        }
        else  {
            $filterValueInput.attr('placeholder', FILTER_VALUE_MORE_PLACEHOLDER);
        }
    }
    $filterValuesBox.removeClass('disabled');
}

//
// BOTTOM BUTTONS
//

function save() {
    if (selectedAmountField === null) {
        $j('.error.amount_field_error').show();
        return false;
    }

    removeFromArray(0, selectedFilters, function(a,b) {
        return a == b.filters.length;
    });

    document.getElementById(hiddenAmountFieldInput).value = JSON.stringify(selectedAmountField);
    document.getElementById(hiddenFiltersInput).value = JSON.stringify(selectedFilters);

    return true;
}

function cancelConfig() {
    loadSelectedAmountField();
    selectCurrentAmountField();

    loadSelectedFilters();
    addExistingFilters();
}

//
// AUTOCOMPLETE
//

function attachAutocomplete($target, data, select, create, search) {
    $target.autocomplete({
        create: function(event, ui) {
            if (create) {
                return create(event, ui);
            }
            return true;
        },
        search: function(event, ui) {
            if (search) {
                return search(event, ui);
            }
            return true;
        },
        select: function(event, ui) {
            var $target = $j(event.target);
            $target.blur();

            if (select) {
                return select(event, ui);
            }
            return true;
        },
        source: data,
        messages: {
            noResults: '',
            results: function() {}
        },
        minLength: 0,
    }).click(function(e) {
        if (!$j(e.target).hasClass('disabled')) {
            $j(this).autocomplete("search", "");
        }
        else {
            $j(e.target).blur();
            e.preventDefault();
            return false;
        }
    });
}

function sortAutocompleteData(data) {
    data.sort(function(a, b) {
        return a.sortkey > b.sortkey;
    });
}

function addAutocompleteItem(item, data) {
    if (item && data) {
        data.push(item);
        sortAutocompleteData(data);
    }
}

function removeAutocompleteItem(item, data) {
    if (item && data) {
        removeFromArray(item, data, function(a,b) {
            return unescapeJsInHtml(a.name) == unescapeJsInHtml(b.name);
        });
    }
}

function removeFromArray(item, data, comparator) {
    var toRemove = [];
    for (var i=0; i < data.length; i++) {
        if (comparator(item, data[i])) {
            toRemove.push(i);
        }
    }
    for (var i=0; i < toRemove.length; i++) {
        data.splice(toRemove[i], 1);
    }
}

function invalidField(field, fields) {
    for (var i=0; i<fields.length; i++) {
        if (unescapeJsInHtml(field.name) == unescapeJsInHtml(fields[i].name)) {
            return false;
        }
    }
    return true;
}
