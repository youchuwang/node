(function() {
  $.fn.kpSwitch = function(options) {
    var defaults, _onClick, _opts;
    defaults = {
      onOption: 'On',
      offOption: 'Off',
      radioStyle: 'circle',
      switchDefault: 'Off',
      switchIcon: false,
      icon: {
        iconOn: 'fa fa-check',
        iconOff: 'fa fa-close'
      }
    };
    _opts = $.extend({}, defaults, options);
    _onClick = function($this, o) {
      var input;
      $this.toggleClass('switch-on switch-off', 'switch-off switch-on');
      input = $this.prev();
      if ($this.hasClass('switch-off') === true) {
        input.attr('checked', 'checked');
        $this.find('span').html(o.onOption);
        return $this.find('i.fa-close').removeClass('fa-close').addClass('fa-check');
      } else {
        input.removeAttr('checked');
        $this.find('span').html(o.offOption);
        return $this.find('i.fa-check').removeClass('fa-check').addClass('fa-close');
      }
    };
    return $(this).each(function() {
      var icon, o, radioStyle, switchBtn;
      o = $.extend({}, _opts, $(this).data());
      $(this).hide();
      radioStyle = 'switch-' + o.radioStyle;
      if (o.radioStyle === 'icon') {
        icon = '<i class="' + o.icon.iconOff + '"></i>';
      } else {
        icon = '';
      }
      $(this).after('<div class="switch-radio switch-on ' + radioStyle + '"><div class="switch-radio-icon">' + icon + '</div><span>' + o.switchDefault);
      switchBtn = this.nextElementSibling;
      $(switchBtn).on('click', function() {
        return _onClick($(this), o);
      });
    });
  };
  return $.fn.kpSwitchAudio = function(options) {
    var defaults, _opts;
    defaults = {
      inputs: {
        off: {
          title: 'Off',
          value: 'off',
          name: 'switch',
          checked: false
        },
        on: {
          title: 'On',
          value: 'on',
          name: 'switch',
          checked: false
        },
        auto: {
          title: 'Auto',
          value: 'auto',
          name: 'switch',
          checked: true
        }
      }
    };
    _opts = $.extend({}, defaults, options);
    $(this).each(function() {
      var activeAuto, activeOff, activeOn, divAll, divRenderAll, inputAuto, inputOff, inputOn, labelAuto, labelOff, labelOn, o;
      $(this).hide();
      o = $.extend({}, _opts, $(this).data());
      labelOff = o.inputs.off.title;
      labelOn = o.inputs.on.title;
      labelAuto = o.inputs.auto.title;
      if (o.inputs.off.checked === true) {
        activeOff = "active checked";
      }
      if (o.inputs.on.checked === true) {
        activeOn = "active checked";
      }
      if (o.inputs.auto.checked === true) {
        activeAuto = "active checked";
      }
      inputOn = '<input type="radio" name="' + o.inputs.on.name + '" value=' + o.inputs.on.value + ' title=' + o.inputs.on.title + ' ' + activeOn + '>';
      inputOff = '<input type="radio" name="' + o.inputs.off.name + '" value=' + o.inputs.off.value + ' title=' + o.inputs.off.title + ' ' + activeOff + '>';
      inputAuto = '<input type="radio" name="' + o.inputs.auto.name + '" value=' + o.inputs.auto.value + ' title=' + o.inputs.auto.title + ' ' + activeAuto + '>';
      $(this).html(inputOff + inputOn + inputAuto);
      divAll = {
        'divSwitchSection': '<div class="audio-switch-section">',
        'divSwitch': '<div class="audio-switch">',
        'divSwitchBar': '<div class="audio-switch-bar">',
        'divSwitchIconOff': '<div class="audio-switch-icon off-btn ' + activeOff + '"></div>',
        'divSwitchIconAuto': '<div class="audio-switch-icon auto-btn ' + activeAuto + '"></div>',
        'divSwitchIconOn': '<div class="audio-switch-icon on-btn ' + activeOn + '"></div></div></div>',
        'divSwitchLabel': '<div class="audio-switch-label">',
        'spanSwitchLabelOff': '<span class="off-label ' + activeOff + '">' + labelOff + '</span>',
        'spanSwitchLabelAuto': '<span class="auto-label ' + activeAuto + '">' + labelAuto + '</span>',
        'spanSwitchLabelOn': '<span class="on-label ' + activeOn + '">' + labelOn + '</span></div></div>'
      };
      divRenderAll = "";
      $.map(divAll, function(value, index) {
        return divRenderAll += value;
      });
      $(this).after(divRenderAll);
      return $('.audio-switch-icon').on('click', function() {
        var switchSection;
        switchSection = this.parentElement.parentElement.parentElement;
        $(switchSection).find('.active').removeClass('active');
        $(this).removeClass('active').addClass('active');
        $(switchSection).prev().find('input').removeAttr('checked');
        if ($(this).hasClass('off-btn') === true) {
          $(switchSection).prev().find('[value="' + o.inputs.off.value + '"]').attr('checked', 'checked');
          $(switchSection).find('.audio-switch-label').find('.off-label').addClass('active');
        }
        if ($(this).hasClass('on-btn') === true) {
          $(switchSection).prev().find('[value="' + o.inputs.on.value + '"]').attr('checked', 'checked');
          $(switchSection).find('.audio-switch-label').find('.on-label').addClass('active');
        }
        if ($(this).hasClass('auto-btn') === true) {
          $(switchSection).prev().find('[value="' + o.inputs.auto.value + '"]').attr('checked', 'checked');
          return $(switchSection).find('.audio-switch-label').find('.auto-label').addClass('active');
        }
      });
    });
  };
})(jQuery);
