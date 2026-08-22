(() => {
  if (window.__highvimMarkdownPreviewControls) return;
  window.__highvimMarkdownPreviewControls = true;

  const headerPosition = window.mkdpHeaderPosition === "bottom" ? "bottom" : "top";
  document.documentElement.dataset.mkdpHeaderPosition = headerPosition;

  function ensureFavicon() {
    let icons = Array.from(document.querySelectorAll('link[rel~="icon"]'));
    if (icons.length === 0) {
      const icon = document.createElement("link");
      document.head.append(icon);
      icons = [icon];
    }
    for (const icon of icons) {
      icon.rel = "icon";
      icon.type = "image/x-icon";
      icon.href = "/_static/highvim-favicon.ico?v=4";
    }
  }

  function readSetting(key, defaultValue) {
    try {
      const stored = window.sessionStorage.getItem(key);
      return stored === null ? defaultValue : stored === "true";
    } catch (_) {
      return defaultValue;
    }
  }

  function saveSetting(key, value) {
    try {
      window.sessionStorage.setItem(key, String(value));
    } catch (_) {
      // The in-memory setting still works for the current page.
    }
  }

  const defaultPageWidth = 1400;
  const minimumPageWidth = 560;
  const pageWidthKey = "highvim-markdown-preview:page-width";
  let widthHandles = [];

  function readPageWidth() {
    try {
      const stored = Number.parseFloat(window.localStorage.getItem(pageWidthKey));
      return Number.isFinite(stored) ? Math.max(minimumPageWidth, stored) : defaultPageWidth;
    } catch (_) {
      return defaultPageWidth;
    }
  }

  function maximumPageWidth() {
    return Math.max(320, window.innerWidth - 24);
  }

  function updateWidthHandleState() {
    const maximum = maximumPageWidth();
    const effectiveWidth = Math.min(pageWidth, maximum);
    for (const handle of widthHandles) {
      handle.setAttribute("aria-valuemin", String(Math.min(minimumPageWidth, maximum)));
      handle.setAttribute("aria-valuemax", String(maximum));
      handle.setAttribute("aria-valuenow", String(Math.round(effectiveWidth)));
      handle.setAttribute("aria-valuetext", `${Math.round(effectiveWidth)} pixels`);
    }
  }

  function applyPageWidth(value, persist = false, constrainToViewport = true) {
    const upperBound = constrainToViewport ? maximumPageWidth() : Number.POSITIVE_INFINITY;
    pageWidth = Math.max(minimumPageWidth, Math.min(upperBound, Math.round(value)));
    document.documentElement.style.setProperty("--mkdp-page-width", `${pageWidth}px`);
    updateWidthHandleState();
    if (persist) {
      try {
        window.localStorage.setItem(pageWidthKey, String(pageWidth));
      } catch (_) {
        // The width still applies for the current page.
      }
    }
  }

  let pageWidth = readPageWidth();
  document.documentElement.style.setProperty("--mkdp-page-width", `${pageWidth}px`);

  function createSwitch({ id, label, title, checked, onChange }) {
    const control = document.createElement("label");
    control.id = id;
    control.className = "mkdp-control";
    control.title = title;

    const input = document.createElement("input");
    input.type = "checkbox";
    input.checked = checked;
    input.setAttribute("role", "switch");
    input.setAttribute("aria-label", label);

    const track = document.createElement("span");
    track.className = "mkdp-switch-track";
    track.setAttribute("aria-hidden", "true");

    const text = document.createElement("span");
    text.className = "mkdp-control-label";
    text.textContent = label;

    control.append(input, track, text);
    input.addEventListener("change", () => onChange(input.checked));
    return control;
  }

  const autoSyncKey = "highvim-markdown-preview:auto-sync:v2";
  const keepOpenKey = "highvim-markdown-preview:keep-open";
  window.mkdpAutoSync = readSetting(autoSyncKey, false);
  window.mkdpKeepOpen = readSetting(keepOpenKey, false);

  const autoSyncControl = createSwitch({
    id: "mkdp-auto-sync",
    label: "Auto Sync",
    title: "Synchronize the preview with the Neovim cursor",
    checked: window.mkdpAutoSync,
    onChange: (checked) => {
      window.mkdpAutoSync = checked;
      saveSetting(autoSyncKey, checked);
    },
  });

  const keepOpenControl = createSwitch({
    id: "mkdp-keep-open",
    label: "Keep Open",
    title: "Keep the last rendered page open after Neovim exits",
    checked: window.mkdpKeepOpen,
    onChange: (checked) => {
      window.mkdpKeepOpen = checked;
      saveSetting(keepOpenKey, checked);
    },
  });

  const controls = document.createElement("div");
  controls.id = "mkdp-controls";
  controls.append(autoSyncControl, keepOpenControl);

  const headerTrigger = document.createElement("div");
  headerTrigger.id = "mkdp-header-trigger";
  headerTrigger.setAttribute("aria-hidden", "true");

  let activeHeader = null;
  let hideHeaderTimer = null;
  let isResizing = false;
  const headerHorizontalHideMargin = 60;
  let isTrackingHorizontalGrace = false;

  function stopHorizontalGraceTracking() {
    if (!isTrackingHorizontalGrace) return;
    isTrackingHorizontalGrace = false;
    document.removeEventListener("pointermove", trackHorizontalGrace);
  }

  function showHeader() {
    window.clearTimeout(hideHeaderTimer);
    stopHorizontalGraceTracking();
    headerTrigger.classList.add("mkdp-header-trigger--active");
    activeHeader?.classList.add("mkdp-header--visible");
  }

  function scheduleHeaderHide() {
    window.clearTimeout(hideHeaderTimer);
    const header = activeHeader;
    hideHeaderTimer = window.setTimeout(() => {
      if (
        !isResizing &&
        !header?.matches(":hover") &&
        !headerTrigger.matches(":hover") &&
        !header?.contains(document.activeElement)
      ) {
        header?.classList.remove("mkdp-header--visible");
        headerTrigger.classList.remove("mkdp-header-trigger--active");
        stopHorizontalGraceTracking();
      }
    }, 180);
  }

  function isWithinHorizontalGrace(event) {
    if (!activeHeader) return false;
    const bounds = activeHeader.getBoundingClientRect();
    return (
      event.clientY >= bounds.top &&
      event.clientY <= bounds.bottom &&
      event.clientX >= bounds.left - headerHorizontalHideMargin &&
      event.clientX <= bounds.right + headerHorizontalHideMargin
    );
  }

  function trackHorizontalGrace(event) {
    if (isResizing || activeHeader?.matches(":hover")) return;
    if (isWithinHorizontalGrace(event)) {
      window.clearTimeout(hideHeaderTimer);
      return;
    }
    stopHorizontalGraceTracking();
    scheduleHeaderHide();
  }

  function holdHeaderWithinHorizontalGrace(event) {
    if (!isWithinHorizontalGrace(event)) return false;
    window.clearTimeout(hideHeaderTimer);
    if (!isTrackingHorizontalGrace) {
      isTrackingHorizontalGrace = true;
      document.addEventListener("pointermove", trackHorizontalGrace);
    }
    return true;
  }

  function handleHeaderMouseLeave(event) {
    const focusedElement = document.activeElement;
    if (
      activeHeader?.contains(focusedElement) &&
      !focusedElement.matches(":focus-visible")
    ) {
      focusedElement.blur();
    }
    if (holdHeaderWithinHorizontalGrace(event)) return;
    scheduleHeaderHide();
  }

  headerTrigger.addEventListener("mouseenter", showHeader);
  headerTrigger.addEventListener("mouseleave", scheduleHeaderHide);

  function createWidthHandle(side) {
    const handle = document.createElement("div");
    let resizeStartWidth = pageWidth;
    let resizeStartX = 0;
    handle.className = `mkdp-width-handle mkdp-width-handle--${side}`;
    handle.tabIndex = 0;
    handle.title = "Drag to resize; double-click to reset";
    handle.setAttribute("role", "separator");
    handle.setAttribute("aria-label", "Preview width");
    handle.setAttribute("aria-orientation", "vertical");

    function resizeFromPointer(event) {
      const direction = side === "right" ? 1 : -1;
      const delta = (event.clientX - resizeStartX) * direction * 2;
      applyPageWidth(resizeStartWidth + delta);
    }

    function finishResize(event) {
      if (!isResizing) return;
      isResizing = false;
      handle.releasePointerCapture?.(event.pointerId);
      document.documentElement.classList.remove("mkdp-resizing");
      applyPageWidth(pageWidth, true);
      if (holdHeaderWithinHorizontalGrace(event)) return;
      scheduleHeaderHide();
    }

    handle.addEventListener("pointerdown", (event) => {
      if (window.innerWidth <= 700) return;
      event.preventDefault();
      resizeStartX = event.clientX;
      resizeStartWidth = Math.min(pageWidth, maximumPageWidth());
      isResizing = true;
      handle.setPointerCapture?.(event.pointerId);
      document.documentElement.classList.add("mkdp-resizing");
      showHeader();
    });
    handle.addEventListener("pointermove", (event) => {
      if (isResizing) resizeFromPointer(event);
    });
    handle.addEventListener("pointerup", finishResize);
    handle.addEventListener("pointercancel", finishResize);
    handle.addEventListener("dblclick", (event) => {
      event.preventDefault();
      applyPageWidth(defaultPageWidth, true, false);
      showHeader();
    });
    handle.addEventListener("keydown", (event) => {
      const step = event.shiftKey ? 100 : 20;
      const effectiveWidth = Math.min(pageWidth, maximumPageWidth());
      let nextWidth = null;
      if (event.key === "ArrowLeft") nextWidth = effectiveWidth - step;
      if (event.key === "ArrowRight") nextWidth = effectiveWidth + step;
      if (event.key === "Home") nextWidth = minimumPageWidth;
      if (event.key === "End") nextWidth = maximumPageWidth();
      if (nextWidth === null) return;
      event.preventDefault();
      applyPageWidth(nextWidth, true);
      showHeader();
    });
    return handle;
  }

  widthHandles = [createWidthHandle("left"), createWidthHandle("right")];
  updateWidthHandleState();
  window.addEventListener("resize", updateWidthHandleState);

  function mountControl() {
    ensureFavicon();
    const header = document.getElementById("page-header");
    const page = document.getElementById("page-ctn");
    const target = header || page;
    if (!target) return;

    const themeControl = document.getElementById("toggle-theme");
    const themeInput = document.getElementById("theme");
    if (themeControl && themeInput) {
      themeControl.title = "Toggle dark mode";
      themeInput.setAttribute("role", "switch");
      themeInput.setAttribute("aria-label", "Dark Mode");
    }

    activeHeader = header;
    if (header && !header.__mkdpAutoHideBound) {
      header.__mkdpAutoHideBound = true;
      header.addEventListener("mouseenter", showHeader);
      header.addEventListener("mouseleave", handleHeaderMouseLeave);
      header.addEventListener("focusin", showHeader);
      header.addEventListener("focusout", scheduleHeaderHide);
    }

    if (header && headerTrigger.parentElement !== document.body) {
      document.body.append(headerTrigger);
    } else if (!header && headerTrigger.parentElement) {
      headerTrigger.remove();
    }

    controls.classList.toggle("mkdp-controls--standalone", !header);
    if (controls.parentElement !== target) {
      if (header) header.append(controls);
      else target.prepend(controls);
    }

    for (const handle of widthHandles) {
      if (header && handle.parentElement !== header) {
        header.append(handle);
      } else if (!header && handle.parentElement) {
        handle.remove();
      }
    }
  }

  const observer = new MutationObserver(mountControl);
  observer.observe(document.documentElement, { childList: true, subtree: true });
  mountControl();
})();
