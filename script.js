const editPosts = document.querySelectorAll(".edit-post");
for (let i = 0; i < editPosts.length; i++) {
  editPosts[i].addEventListener("click", function() {
    const editForm = editPosts[i].parentElement.parentElement.querySelector(".edit-form");
    editForm.classList.toggle("unvisible");
  });
}

const deletePosts = document.querySelectorAll(".delete-post");
for (let i = 0; i < deletePosts.length; i++) {
  deletePosts[i].addEventListener("click", function() {
    const deleteForm = editPosts[i].parentElement.parentElement.querySelector(".delete-form");
    deleteForm.classList.toggle("unvisible");
  });
}