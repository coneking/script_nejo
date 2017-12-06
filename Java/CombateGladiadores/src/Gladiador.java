
import java.util.Random;
import java.util.*;

public class Gladiador {
    public static Scanner s = new Scanner(System.in);
    public String nombre;
    public String estado = "En guardia";
    public String historia;
    public String derrota = "No puede estar pasando!!! NOOOOOOOOOOOOOOOOO...!!! ";
    public String victoria = "Te hace falta más entrenamiento... Y valor para derrotarme!!!";
    public int bono_Energia=0;
    public int bono_dano=0;
    public int danototal=0;
    public int energia = 1000;
    public int fuerza;
    public int vida;
    
    
    public int getVida() {
        return vida;
    }

    public void setVida(int contador) {
        this.vida = contador;
        if (this.vida >= 9) {
            this.estado = "Derrotado";

        }
    }
    
        
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEstado() {
        return estado;
    }

    public int getEnergia() {
        return energia;
    }

    public int getFuerza() {
        return fuerza;
    }

    public void setFuerza(int fuerza) {
        this.fuerza = fuerza;
    }

    public int atacar() {
        Random rnd = new Random();
        int danototal = 0;
        danototal = this.fuerza = rnd.nextInt(50);
        return danototal;
    }

    public void Dano(int danorecibido) {
        this.energia = this.energia - danorecibido;
        if (this.energia <= 0) {
            this.estado = "Derrotado";

        }
    }

    public String getHistoria() {
        return historia;
    }

    public void setHistoria(String historia) {
        this.historia = historia;
    }

    public String getVictoria() {
        return victoria;
    }

    public void setVictoria(String victoria) {
        this.victoria = victoria;
    }

    public String getDerrota() {
        return derrota;
    }

    public void setDerrota(String derrota) {
        this.derrota = derrota;
    }

    public int aumentaVida() {
        do {
            System.out.print("El Enano usa Aumento de Energía y suma entre 50 y 100, eliga el aumento: ");
            bono_Energia = Integer.parseInt(s.nextLine());
        } while (bono_Energia > 100 || bono_Energia < 50);
        energia = bono_Energia + energia;
        System.out.println("");
        return energia;

    }

    public int quitaVida() {
        //System.out.println("");
        System.out.println("Elfo aplica un hechizo y reduce el 10% de la energía del Rival!!");
        System.out.println("");
        energia = energia * 90 / 100;
        return energia;
    }

    public int superBono() {
        do {
            System.out.print("Hombre usa SuperBono!!!, elija el plus de daño entre 5 y 15: ");
            bono_dano = Integer.parseInt(s.nextLine());
        } while (bono_dano > 15 || bono_dano < 5);
        //danototal = bono_dano + danototal;
        System.out.println("");
        return bono_dano + atacar();

    }
    
    public String excepciones(String ewxcepciones){
        try {
            int opcion = Integer.parseInt(s.nextLine());
                } catch (InputMismatchException ex) {
                    s.nextLine();
                    //System.out.print("Valor ingresado incorrecto, inténtelo una vez más\n");
                } catch (NumberFormatException ex) {
                    System.out.println("No ingresó un número \n");
                }
        return ewxcepciones;
    }
}
