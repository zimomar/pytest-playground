# 🎯 Crash Course - Tests en Python

## 📌 1. Installation des outils

### 🔹 Installation automatique via script

Un script `.bat` est disponible pour configurer automatiquement l'environnement de test.

1. Téléchargez le dépôt et placez-vous dans le dossier du projet.
2. Exécutez le script `setup_env.bat` (Windows) :
   ```
   setup_env.bat
   ```

### 🔹 Installation manuelle

Si vous préférez installer manuellement les dépendances, utilisez :
```bash
pip install -r requirements.txt
```

---
## 🔹 2. Principe AAA (Arrange - Act - Assert)

Chaque test doit suivre cette structure :

1️⃣ **Arrange** → Préparer les données et objets nécessaires  
2️⃣ **Act** → Exécuter l’action à tester  
3️⃣ **Assert** → Vérifier le résultat

---
## 🔹 3. Tester une fonction simple avec `pytest`

### **📌 Code source (`calculator.py`)**
```python
class Calculator:
    def add(self, a: int, b: int) -> int:
        return a + b
```

### **📝 Test unitaire (`test_calculator.py`)**
```python
import pytest
from calculator import Calculator

def test_add():
    # Arrange
    calculator = Calculator()

    # Act
    result = calculator.add(2, 3)

    # Assert
    assert result == 5
```

### **🚀 Exécution des tests**
```bash
pytest
```

---
## 🔹 4. Tester une exception

Une méthode qui divise deux nombres et doit lever une exception si on divise par zéro.

### **📌 Code source (`calculator.py`)**
```python
class Calculator:
    def divide(self, a: int, b: int) -> float:
        if b == 0:
            raise ValueError("Impossible de diviser par zéro.")
        return a / b
```

### **📝 Test avec exception attendue (`test_calculator.py`)**
```python
import pytest
from calculator import Calculator

def test_divide_by_zero():
    calculator = Calculator()

    with pytest.raises(ValueError, match="Impossible de diviser par zéro."):
        calculator.divide(10, 0)
```

---
## 🔹 5. Utiliser `unittest` (alternative à `pytest`)

### **📝 Test avec `unittest`**
```python
import unittest
from calculator import Calculator

class TestCalculator(unittest.TestCase):
    def setUp(self):
        self.calculator = Calculator()

    def test_add(self):
        result = self.calculator.add(2, 3)
        self.assertEqual(result, 5)

    def test_divide_by_zero(self):
        with self.assertRaises(ValueError):
            self.calculator.divide(10, 0)

if __name__ == "__main__":
    unittest.main()
```

### **🚀 Exécution des tests**
```bash
python -m unittest test_calculator.py
```

---
## 🔹 6. Mocking avec `pytest-mock`

Si ton code dépend d’une base de données ou d’une API, il faut **mock** cette dépendance.

### **📌 Code source avec une dépendance (`calculator.py`)**
```python
class Logger:
    def log(self, message: str):
        print(message)  # Simule un enregistrement de logs

class Calculator:
    def __init__(self, logger: Logger):
        self.logger = logger

    def add(self, a: int, b: int) -> int:
        result = a + b
        self.logger.log(f"Addition de {a} et {b} : {result}")
        return result
```

### **📝 Test en mockant `Logger` (`test_calculator.py`)**
```python
import pytest
from calculator import Calculator, Logger

def test_add_logs_message(mocker):
    logger_mock = mocker.Mock(spec=Logger)
    calculator = Calculator(logger_mock)

    calculator.add(2, 3)

    logger_mock.log.assert_called_once_with("Addition de 2 et 3 : 5")
```

---
## 🔹 7. Exécuter tous les tests

Dans le terminal :
```bash
pytest
```
Si tout fonctionne, tu verras ✅✅✅ dans la sortie.

---
## 🚀 **Conclusion**
- ✅ Utiliser `pytest` pour des tests rapides et efficaces
- ✅ Suivre le principe **AAA (Arrange - Act - Assert)**
- ✅ Tester les cas normaux ET les erreurs
- ✅ Utiliser `pytest-mock` pour **mocker** les dépendances
- ✅ `unittest` est une alternative native si besoin

Tu es prêt à écrire des tests solides en Python ! 🔥
