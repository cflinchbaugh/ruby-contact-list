document.addEventListener("turbo:load", () => {
  const imageInput = document.getElementById("image_input");
  const imagePreview = document.getElementById("image_preview");
  const imagePreviewContainer = document.getElementById(
    "image_preview_container"
  );
  const clearButton = document.getElementById("clear_image");

  if (!imageInput || !imagePreview || !clearButton) return; // Avoids console errors on non image-uploading pages

  clearButton.disabled = true;

  imageInput.addEventListener("change", function (event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();

      reader.onload = function (e) {
        imagePreview.src = e.target.result; // Set the preview source to the selected image
        imagePreviewContainer.style.display = "block"; // Show the image preview
      };

      reader.readAsDataURL(file); // Read the file as a data URL

      clearButton.disabled = !file;
    } else {
      imagePreviewContainer.style.display = "none"; // Hide the image preview if no file is selected
    }
  });

  clearButton.addEventListener("click", () => {
    imageInput.value = ""; // Clear the file input
    imagePreview.src = "";
    imagePreviewContainer.style.display = "none";
    clearButton.disabled = true;
  });
});
