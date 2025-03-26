document.addEventListener("DOMContentLoaded", function () {
  const avatarInput = document.getElementById("avatar_input");
  const avatarPreview = document.getElementById("avatar_preview");
  const avatarPreviewContainer = document.getElementById(
    "avatar_preview_container"
  );

  avatarInput.addEventListener("change", function (event) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();

      reader.onload = function (e) {
        avatarPreview.src = e.target.result; // Set the preview source to the selected image
        avatarPreview.style.display = "block"; // Show the image preview
      };

      reader.readAsDataURL(file); // Read the file as a data URL
    } else {
      avatarPreview.style.display = "none"; // Hide the image preview if no file is selected
    }
  });
});
