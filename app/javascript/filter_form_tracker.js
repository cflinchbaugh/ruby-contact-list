/**
 * @description Monitor filters for changes and update the Apply button styling
 */

// Turbo Drive (from Hotwire) intercepts link clicks and form submissions to speed up page transitions using AJAX, without doing a full page reload. But when it does that, the DOMContentLoaded event doesn't fire again, JS won't reinit which is why the event listener must be set to turbo:load
document.addEventListener("turbo:load", () => {
  const form = document.getElementById("filters-form");
  const submitButton = document.getElementById("filter-submit");

  if (!form || !submitButton) return;

  const initialData = new FormData(form);

  const getFormSnapshot = () => {
    const snapshot = {};
    for (const [key, value] of new FormData(form).entries()) {
      snapshot[key] ||= [];
      snapshot[key].push(value);
    }
    return snapshot;
  };

  const isDifferent = () => {
    const current = getFormSnapshot();
    const initial = {};
    for (const [key, value] of initialData.entries()) {
      initial[key] ||= [];
      initial[key].push(value);
    }

    const allKeys = new Set([...Object.keys(initial), ...Object.keys(current)]);
    for (const key of allKeys) {
      const a = (initial[key] || []).sort();
      const b = (current[key] || []).sort();
      if (a.length !== b.length || !a.every((v, i) => v === b[i])) {
        return true;
      }
    }
    return false;
  };

  form.addEventListener("input", () => {
    if (isDifferent()) {
      submitButton.classList.remove("btn-outline-primary");
      submitButton.classList.add("btn-primary");
    } else {
      submitButton.classList.remove("btn-primary");
      submitButton.classList.add("btn-outline-primary");
    }
  });
});
