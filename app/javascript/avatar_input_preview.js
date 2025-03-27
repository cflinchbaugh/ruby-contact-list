document.addEventListener("turbo:load", () => {
  const avatarInput = document.getElementById("avatar_input");
  const avatarPreview = document.getElementById("avatar_preview");
  const avatarPreviewContainer = document.getElementById(
    "avatar_preview_container"
  );
  const clearButton = document.getElementById("clear_avatar");

  if (!avatarInput || !avatarPreview || !clearButton) return; // Avoids console errors on non avatar-uploading pages

  clearButton.disabled = true;

  avatarInput.addEventListener("change", function (event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();

      reader.onload = function (e) {
        avatarPreview.src = e.target.result; // Set the preview source to the selected image
        avatarPreviewContainer.style.display = "block"; // Show the image preview
      };

      reader.readAsDataURL(file); // Read the file as a data URL

      clearButton.disabled = !file;
    } else {
      avatarPreviewContainer.style.display = "none"; // Hide the image preview if no file is selected
    }
  });

  clearButton.addEventListener("click", () => {
    avatarInput.value = ""; // Clear the file input
    avatarPreview.src = "";
    avatarPreviewContainer.style.display = "none";
    clearButton.disabled = true;
  });
});
