
import java.util.Random;

public class Gladiador {
    private String nombre;
    private String estado = "En guardia";
    private int energia = 100;
    private int fuerza;
    private String historia;
    
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
    
    public int atacar(){
        Random rnd = new Random();
        int danototal = 0;
        danototal = this.fuerza = rnd.nextInt(50);
        return danototal;
    }

    public void recibirDano(int danorecibido){
        this.energia = this.energia - danorecibido;
        if(this.energia <= 0){
            this.estado = "Derrotado";
            
        }
    }
    
    public String getHistoria() {
        return historia;
    }

    public void setHistoria(String historia) {
        this.historia = historia;
    }
}
