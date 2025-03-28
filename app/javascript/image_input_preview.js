const ALLOWED_TYPES = ["image/jpeg", "image/png"];
const MAX_FILE_SIZE_MB = 1; // In megabytes
const maxSizeBytes = MAX_FILE_SIZE_MB * 1024 * 1024;

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

    if (!file) {
      imagePreviewContainer.style.display = "none"; // Hide the image preview if no file is selected
      return;
    }

    // Validate type
    if (!ALLOWED_TYPES.includes(file.type)) {
      alert("Only JPG and PNG images are allowed.");
      imageInput.value = "";
      imagePreviewContainer.style.display = "none";
      return;
    }

    // Validate size
    if (file.size > maxSizeBytes) {
      alert(`File size must be less than ${MAX_FILE_SIZE_MB} MB.`);
      imageInput.value = "";
      imagePreviewContainer.style.display = "none";
      return;
    }

    const reader = new FileReader();

    reader.onload = function (e) {
      imagePreview.src = e.target.result; // Set the preview source to the selected image
      imagePreviewContainer.style.display = "block"; // Show the image preview
    };

    reader.readAsDataURL(file); // Read the file as a data URL

    clearButton.disabled = !file;
  });

  clearButton.addEventListener("click", () => {
    imageInput.value = ""; // Clear the file input
    imagePreview.src = "";
    imagePreviewContainer.style.display = "none";
    clearButton.disabled = true;
  });
});
