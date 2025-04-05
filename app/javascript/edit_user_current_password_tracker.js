document.addEventListener("turbo:load", () => {
  const currentPasswordInput = document.getElementById(
    "current-password-input"
  );
  const updateSubmitButton = document.getElementById("update-profile-submit");

  if (!currentPasswordInput || !updateSubmitButton) return;

  const toggleSubmitButton = () => {
    const hasValue = currentPasswordInput.value.trim().length > 0;
    updateSubmitButton.disabled = !hasValue;

    hasValue
      ? updateSubmitButton.classList.remove("disabled")
      : updateSubmitButton.classList.add("disabled");
  };

  // Initial check
  toggleSubmitButton();

  // Listen for input
  currentPasswordInput.addEventListener("input", toggleSubmitButton);
});
