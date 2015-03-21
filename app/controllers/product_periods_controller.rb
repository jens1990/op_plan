#encoding: UTF-8

class ProductPeriodsController < ApplicationController
  respond_to :html, :json
  before_filter :signed_in_user


  # GET /product_periods
  # GET /product_periods.json
  def index
    @product_periods = ProductPeriod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_periods }
    end
  end


  # GET /product_periods/1
  # GET /product_periods/1.json
  def show
    @product_period = ProductPeriod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product_period }
    end
  end

  # GET /product_periods/new
  # GET /product_periods/new.json
  #  def new
  #    @product_period = ProductPeriod.new

  #    respond_to do |format|
  #      format.html # new.html.erb
  #      format.json { render json: @product_period }
  #    end
  #  end

  # GET /product_periods/1/edit
  def edit
    @product_period = ProductPeriod.find(params[:id])
  end

  # POST /product_periods
  # POST /product_periods.json
  #  def create
  #    @product_period = ProductPeriod.new(params[:product_period])

  #    respond_to do |format|
  #      if @product_period.save
  #        format.html { redirect_to @product_period, notice: 'Produkt wurde erfolgreich angelegt!' }
  #        format.json { render json: @product_period, status: :created, location: @product_period }
  #      else
  #        format.html { render action: "new" }
  #        format.json { render json: @product_period.errors, status: :unprocessable_entity }
  #      end
  #    end
  #  end

  # PUT /product_periods/1
  # PUT /product_periods/1.json
  def update
    @product_period = ProductPeriod.find(params[:id])

    respond_to do |format|
      if @product_period.update_attributes(params[:product_period])
        format.html { redirect_to @product_period, notice: 'Produkt   wurde erfolgreich aktualisiert.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product_period.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_periods/1
  # DELETE /product_periods/1.json
  #  def destroy
  #    @product_period = ProductPeriod.find(params[:id])
  #    @product_period.destroy

  #   respond_to do |format|
  #     format.html { redirect_to product_periods_url }
  #     format.json { head :no_content }
  #   end
  # end

  def optimize

    if File.exist?("MLCLSP_Input.inc")
      File.delete("MLCLSP_Input.inc")
    end
    f=File.new("MLCLSP_Input.inc", "w")
    printf(f, "set k / \n")
    @products = Product.all
    @products.each { |prod| printf(f, prod.name + "\n") }
    printf(f, "/" + "\n\n")

    printf(f, "set t / \n")
    @periods = Period.all
    @periods.each { |per| printf(f, "t"+per.name + "\n") }
    printf(f, "/" + "\n\n")


    printf(f, "set j / \n")
    @machines = Machine.all
    @machines.each { |mac| printf(f, mac.name + "\n") }
    printf(f, "/;\n\n")


    printf(f, "KT(k,t)=yes;\n")
    printf(f, "JT(j,t)=yes;\n\n")
    printf(f, "KJ(k,j)=no;\n")
    printf(f, "KK(k,k)=no;\n\n")

    printf(f, "set kta / \n")
    @product_periods = ProductPeriod.all
    @product_periods.each { |prod_per| printf(f, "kta" + prod_per.id.to_s + "\n") }
    printf(f, "/;" + "\n\n")

    printf(f, "KTaKT(kta,k,t)=no;" + "\n\n")
    @product_periods.each { |prod_per| printf(f, "KTaKT('kta" + prod_per.id.to_s + "','" + prod_per.product.name + "','t" + prod_per.period.name + "')=yes;\n") }
    printf(f, "\n\n")


    printf(f, "set jta / \n")
    @machine_periods = MachinePeriod.all
    @machine_periods.each { |mac_per| printf(f, "jta" + mac_per.id.to_s + "\n") }
    printf(f, "/;" + "\n\n")

    printf(f, "JTaJT(jta,j,t)=no;" + "\n\n")
    @machine_periods.each { |mac_per| printf(f, "JTaJT('jta" + mac_per.id.to_s + "','" + mac_per.machine.name + "','t" + mac_per.period.name + "')=yes;\n") }
    printf(f, "\n\n")


    @product_machines = ProductMachine.all
    @product_machines.each { |pro_mac| printf(f, "KJ('" + pro_mac.product.name+"','" + pro_mac.machine.name+"')=yes;\n") }

    printf(f, "\n")

    printf(f, "a(k,i)=0;\n")

    @product_products = ProductProduct.all
    @product_products.each { |pro_pro|
      printf(f, "KK('" + pro_pro.from_product.name+"','" + pro_pro.to_product.name+"')=yes;\n")
      printf(f, "a('" + pro_pro.from_product.name+"','" + pro_pro.to_product.name+"')= "+ pro_pro.coefficient.to_s + ";\n")
    }

    printf(f, "\n")

    @products.each { |prod|
      printf(f, "ts('" + prod.name + "')= "+ prod.setup_time.to_s + ";\n")
      printf(f, "tp('" + prod.name + "')= "+ prod.processing_time.to_s + ";\n")
      printf(f, "s('" + prod.name + "')= "+ prod.setup_cost.to_s + ";\n")
      printf(f, "h('" + prod.name + "')= "+ prod.holding_cost.to_s + ";\n")
      printf(f, "y_0('" + prod.name + "')= "+ prod.initial_inventory.to_s + ";\n")
      printf(f, "z('" + prod.name + "')= "+ prod.lead_time_periods.to_s + ";\n")
      printf(f, "\n")

    }

    printf(f, "\n")

    @machines.each { |mac|
      printf(f, "oc('" + mac.name + "')= "+ mac.overtime_cost.to_s + ";\n")
    }

    printf(f, "\n")


    @machine_periods = MachinePeriod.all
    @machine_periods.each { |mac_per|
      printf(f, "C('" +mac_per.machine.name+"','t" + mac_per.period.name+"')= "+ mac_per.capacity.to_s + ";\n")
    }

    printf(f, "\n")


    @product_periods = ProductPeriod.all
    @product_periods.each { |pro_per|
      printf(f, "d('" +pro_per.product.name+"','t" + pro_per.period.name+"')= "+ pro_per.demand.to_s + ";\n")
    }


    f.close


    if File.exist?("MLClSP_solution.txt")
      File.delete("MLCLSP_solution.txt")
    end

    system "C:\\GAMS\\win64\\23.9\\gams MLCLSP_omapps"

    flash.now[:started] = "Die Rechnung wurde gestartet!"

    render 'static_pages/mlclsp_start'


  end

  def delete_old_plan

    if File.exist?("MLCLSP_solution_kt.txt")
      File.delete("MLCLSP_solution_kt.txt")
    end

    if File.exist?("MLCLSP_solution_jt.txt")
      File.delete("MLCLSP_solution_jt.txt")
    end

    if File.exist?("MLCLSP_ofv.txt")
      File.delete("MLCLSP_ofv.txt")
    end

    @product_periods = ProductPeriod.all
    @product_periods.each { |pro_per|
      pro_per.production=nil
      pro_per.inventory=nil
      pro_per.setup=nil
      pro_per.save
    }

    @machine_periods = MachinePeriod.all
    @machine_periods.each { |mac_per|
      mac_per.overtime=nil
      mac_per.save
    }

    @objective_function_value=nil

    render :template => "product_periods/index"

  end


  def read_optimization_results


    if (File.exist?("MLCLSP_solution_kt.txt") and File.exists?("MLCLSP_solution_jt.txt"))

      fi=File.open("MLCLSP_solution_kt.txt", "r")
      fi.each { |line|
        sa=line.split(";")
        sa0=sa[0].delete "kta "
        sa3=sa[3]
        sa4=sa[4]
        sa5=sa[5].delete " \n"
        product_period=ProductPeriod.find_by_id(sa0)
        product_period.production = sa3
        product_period.inventory = sa4
        product_period.setup = sa5
        product_period.save
      }
      fi.close

      fi=File.open("MLCLSP_solution_jt.txt", "r")
      fi.each { |line|
        sa=line.split(";")
        sa0=sa[0].delete "jta "
        sa3=sa[3].delete " \n"
        machine_period=MachinePeriod.find_by_id(sa0)
        machine_period.overtime = sa3
        machine_period.save
      }
      fi.close

    else
      flash.now[:not_available] = "Die Lösung wurde noch nicht berechnet!"
    end
    @product_periods = ProductPeriod.all
    render :template => "product_periods/index"

  end


  def read_and_show_ofv

    if File.exist?("MLCLSP_ofv.txt")
      fi=File.open("MLCLSP_ofv.txt", "r")
      line=fi.readline
      fi.close
      sa=line.split(" ")
      @objective_function_value=sa[1]
    else
      @objective_function_value=nil
      flash.now[:not_available] = "Zielfunktionswert wurde noch nicht berechnet!"

    end

    @product_periods = ProductPeriod.all
    render :template => "product_periods/index"
  end


end

private

def signed_in_user
  unless signed_in?
    store_location
    redirect_to signin_path, notice: "Bitte melden Sie sich an."
  end
end