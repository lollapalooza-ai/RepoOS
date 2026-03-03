# Refactoring Ideas for django-oscar/src/oscar

The following 10 refactoring ideas are independent and aimed at improving the codebase's maintainability, type safety, and modern standards.

## 1. Move `UnicodeCSVWriter` to a Dedicated CSV Utility Module
**Description:** 
Currently, the `UnicodeCSVWriter` class is located in `oscar/core/compat.py`, which is intended for compatibility layers. However, this class is a general-purpose utility for handling CSV files with Byte Order Marks (BOM) for Excel compatibility.
**Prompt:**
Refactor the codebase by moving the `UnicodeCSVWriter` class from its current location in `oscar/core/compat.py` to a more appropriate, logically isolated utility module named `oscar/core/csv_utils.py`. Ensure that all existing imports of this class throughout the project are updated and the functionality remains intact.

## 2. Add Type Hinting to `oscar/core/loading.py`
**Description:** 
The `oscar/core/loading.py` module is the core of Oscar's extensibility mechanism, providing functions like `get_class`, `get_classes`, and `get_model` for dynamic importing. Currently, these functions lack type hints, which limits IDE support for developers.
**Prompt:**
Enhance the `oscar/core/loading.py` module by adding Python 3 type hints to its primary public functions, including `get_class`, `get_classes`, `get_model`, and `is_model_registered`. Ensure all necessary types are imported from the `typing` and `django.db` modules to provide full type safety and improved IDE autocompletion.

## 3. Modernize `get_user_model` in `oscar/core/compat.py`
**Description:** 
The `get_user_model` function in `oscar/core/compat.py` contains legacy comments referring to Django 1.4 support, which has been dropped. It also performs manual annotation of the user model's `_meta` class.
**Prompt:**
Modernize the `get_user_model` function in `oscar/core/compat.py` by removing obsolete comments regarding Django 1.4. Additionally, clean up the manual annotation of the user model's `_meta` class to align with modern Django best practices while maintaining compatibility with the rest of the Oscar codebase.

## 4. Extract BOM Handling into a Standalone Utility
**Description:** 
The logic for adding a Byte Order Mark (BOM) to a file is currently embedded within `UnicodeCSVWriter.add_bom`. This logic is useful for other file types beyond just CSVs.
**Prompt:**
Extract the Byte Order Mark (BOM) handling logic from `UnicodeCSVWriter` and encapsulate it into a reusable standalone utility function within `oscar/core/utils.py`. Update `UnicodeCSVWriter` and any other relevant parts of the system to use this new utility, ensuring it respects the `OSCAR_CSV_INCLUDE_BOM` configuration.

## 5. Granular Validation Logic for `AbstractProduct.clean`
**Description:** 
The `AbstractProduct.clean` method in `oscar/apps/catalogue/abstract_models.py` handles complex validation for standalone, parent, and child products. While it already delegates to sub-methods, these can be further refined to improve extensibility.
**Prompt:**
Refactor the validation logic within `AbstractProduct` in `oscar/apps/catalogue/abstract_models.py` to be more granular. Break down the existing `_clean_standalone`, `_clean_child`, and `_clean_parent` methods into smaller, atomic validation helpers to allow for easier overriding and customization by downstream developers.

## 6. Move `ReverseStartsWith` Lookup to a Dedicated Module
**Description:** 
The custom Django lookup `ReverseStartsWith` is currently defined and registered directly within `oscar/apps/catalogue/abstract_models.py`. This litters the models file with database-level logic.
**Prompt:**
Decouple the database lookup logic from the model definitions by moving the `ReverseStartsWith` class and its registration from `oscar/apps/catalogue/abstract_models.py` to a dedicated `oscar/core/models/lookups.py` module. Ensure the lookup is correctly registered upon application startup.

## 7. Add Type Hinting to `oscar/core/utils.py`
**Description:** 
Common utility functions in `oscar/core/utils.py` like `slugify`, `format_datetime`, and `round_half_up_two_dec` are used throughout the codebase but lack type hints.
**Prompt:**
Implement comprehensive Python 3 type hinting for all public utility functions within `oscar/core/utils.py`. This includes functions for slugification, date formatting, and decimal rounding, ensuring they are properly typed for better maintainability and developer experience.

## 8. Improve Error Context in `oscar/core/loading._import_module`
**Description:** 
The `_import_module` function in `oscar/core/loading.py` suppresses certain `ImportError` exceptions while re-raising others based on the traceback length. This can sometimes make debugging difficult.
**Prompt:**
Refactor the `_import_module` function in `oscar/core/loading.py` to improve the clarity of its error reporting. When an `ImportError` is re-raised, provide additional context such as the specific module label being loaded and the underlying reason for the failure, without compromising the existing circular import detection logic.

## 9. Standardize Abstract Model Docstrings
**Description:** 
Docstrings for abstract models in `oscar/apps/catalogue/abstract_models.py` vary in detail and format. Some models like `AbstractProduct` have extensive documentation, while others like `AbstractProductCategory` are minimal.
**Prompt:**
Perform a comprehensive audit and standardization of the docstrings within `oscar/apps/catalogue/abstract_models.py`. Ensure all abstract models, fields, and methods have clear, consistent, and Sphinx-compatible documentation that provides sufficient detail for developers forking or extending the catalogue app.

## 10. Enhance `deprecated` Decorator with `functools.wraps`
**Description:** 
The `deprecated` decorator in `oscar/core/decorators.py` currently does not use `functools.wraps`, which means it loses the metadata (like `__name__`, `__doc__`, etc.) of the decorated functions.
**Prompt:**
Enhance the `deprecated` decorator in `oscar/core/decorators.py` by utilizing `functools.wraps` to preserve the metadata of decorated functions and classes. Additionally, update the decorator to allow for more informative warning messages, such as including the specific version in which the feature will be removed.
